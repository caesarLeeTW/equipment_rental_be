
class EquipmentList < ApplicationRecord
  attribute :id
  attribute :name, :string, default: -> { '' }
  attribute :description, :string, default: -> { '' }
  attribute :json_image_list, :string, default: -> { '[]' }

  [:json_image_list].each do |x|
    get_method = x.to_s
    set_method = "#{x.to_s}="
    new_get_method = get_method.to_s[5..]
    new_set_method = set_method.to_s[5..]
    define_method(new_get_method.to_sym) {Oj.load(self.public_send(get_method.to_sym))}
    define_method(new_set_method.to_sym) {|v| self.public_send(set_method.to_sym, Oj.dump(v)) }
  end

  # include ActiveModel::Validations
  # validates_with EquipmentValidator
  validates :name, :description, :json_image_list, presence: true

  scope :by_id, lambda {|x| where(id: x)}

end