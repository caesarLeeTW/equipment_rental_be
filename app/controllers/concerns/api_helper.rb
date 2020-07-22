module ApiHelper

  ERR_BASE = 9000
  SUCC = 0
  NO_ROUTE = ERR_BASE + 10
  API_PARAM_TYPE_CHECK_FAIL = ERR_BASE + 700
  API_PARAM_PRESENT_CHECK_FAIL = ERR_BASE + 701
  RUBY_EXCEPTION = ERR_BASE + 50
  DB_DELETE_FAIL = ERR_BASE + 800
  DB_SEARCH_NOT_FOUND_FAIL = ERR_BASE + 801
  DB_UPDATE_FAIL = ERR_BASE + 802

  class APIParamTypeCheckFail < StandardError;end
  class APIParamPresentCheckFail < StandardError;end

  extend ActiveSupport::Concern

  included do
    rescue_from Exception, :with => :render_error_json
    rescue_from APIParamTypeCheckFail, :with => :render_param_type_check_fail_error_json
    rescue_from APIParamPresentCheckFail, :with => :render_param_present_check_fail_error_json
  end

  def params_check must_have, must_type
    must_have.each do |x|
      raise APIParamPresentCheckFail.new(x) if params[x].blank?
    end

    must_type.each do |x|
      name, type = x.split(':')

      next if params[name].blank?

      case type
      when 'integer'
        raise APIParamTypeCheckFail.new(name) unless params[name].to_s =~ /^[0-9]*$/
      when 'array'
        raise APIParamTypeCheckFail.new(name) unless params[name].is_a? Array
      when 'dbdate'
        raise APIParamTypeCheckFail.new(name) unless params[name].to_s =~ /^\d\d\d\d-\d\d-\d\d$/
      when 'string'

      else
        raise 'undefined param check type !'
      end
    end
  end

  def render_ret_code r
    render_json({ret: r})
  end

  def render_json j
    render json: Oj.dump(j)
  end

  def render_param_present_check_fail_error_json e
    render json: Oj.dump({ret: API_PARAM_PRESENT_CHECK_FAIL, reason: e.to_s})
  end

  def render_param_type_check_fail_error_json e
    render json: Oj.dump({ret: API_PARAM_TYPE_CHECK_FAIL, reason: e.to_s})
  end

  def render_error_json e
    render json: Oj.dump({ret: RUBY_EXCEPTION, reason: e.to_s})
  end
  
end