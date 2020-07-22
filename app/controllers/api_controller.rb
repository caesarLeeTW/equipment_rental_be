require 'api_helper'

class ApiController < ApplicationController
  include ApiHelper
  
  # = = = equipment list = = = = = = = = = = = = = = = = = = = = = = = =

  def get_equipment_list
    ret = EquipmentList.all.map {|x| {id: x.id, name: x.name, description: x.description, images: x.image_list} }
    render_json({ret: SUCC, value: ret})
  end

  def create_equipment
    params_check([:name, :description, :images], ['name:string', 'description:string', 'images:array'])
    value = {name: params[:name], description: params[:description], json_image_list: Oj.dump(params[:images])}
    EquipmentList.create(value)
    render_ret_code(SUCC)
  end

  def update_equipment
    params_check([:id], ['id:integer', 'name:string', 'description:string', 'images:array'])
    obj = EquipmentList.by_id(params[:id]).first
    return render_ret_code(DB_SEARCH_NOT_FOUND_FAIL) unless obj

    (obj.name = params[:name]) if params[:name]
    (obj.description = params[:description]) if params[:description]
    (obj.json_image_list = Oj.dump(params[:images])) if params[:images]
    ret = obj.save
    render_ret_code(ret ? SUCC : DB_UPDATE_FAIL)
  end

  def delete_equipment
    params_check([:id], ['id:integer'])
    ret = EquipmentList.delete(params[:id])
    render_ret_code( ret == 1 ? SUCC : DB_DELETE_FAIL )
  end

  # = = = rental request = = = = = = = = = = = = = = = = = = = = = = = =

  def get_rental_request_list
    ret = RentalRequest.all.map do |x| 
      { id: x.id, 
        customer_name: x.customer_name, 
        customer_info: x.customer_info, 
        total_price: x.total_price,
        pickup_date: x.pickup_date.to_formatted_s,
        dropoff_date: x.dropoff_date.to_formatted_s,
        detail: x.detail,
      }
    end
    render_json({ret: SUCC, value: ret})
  end

  def create_rental_request
    params_check(
      [:customer_name, :customer_info, :total_price, :pickup_date, :dropoff_date, :detail], 
      ['customer_name:string', 'customer_info:string', 'total_price:integer', 'pickup_date:dbdate', 'dropoff_date:dbdate', 'detail:string']
    )
    value = { customer_name: params[:customer_name], 
              customer_info: params[:customer_info], 
              total_price: params[:total_price].to_i, 
              pickup_date: params[:pickup_date], 
              dropoff_date: params[:dropoff_date], 
              detail: params[:detail]
            }
    RentalRequest.create(value)
    render_ret_code(SUCC)
  end

  def update_rental_request
    params_check(
      [:id], 
      ['id:integer', 'customer_name:string', 'customer_info:string', 'total_price:integer', 'pickup_date:dbdate', 'dropoff_date:dbdate', 'detail:string']
    )
    obj = RentalRequest.by_id(params[:id]).first
    return render_ret_code(DB_SEARCH_NOT_FOUND_FAIL) unless obj

    (obj.customer_name = params[:customer_name]) if params[:customer_name]
    (obj.customer_info = params[:customer_info]) if params[:customer_info]
    (obj.total_price = params[:total_price].to_i) if params[:total_price]
    (obj.pickup_date = params[:pickup_date]) if params[:pickup_date]
    (obj.dropoff_date = params[:dropoff_date]) if params[:dropoff_date]
    (obj.detail = params[:detail]) if params[:detail]
    ret = obj.save
    render_ret_code(ret ? SUCC : DB_UPDATE_FAIL)
  end

  def delete_rental_request
    params_check([:id], ['id:integer'])
    ret = RentalRequest.delete(params[:id])
    render_ret_code( ret == 1 ? SUCC : DB_DELETE_FAIL )
  end

  def no_route
    render_ret_code(NO_ROUTE)
  end
end

