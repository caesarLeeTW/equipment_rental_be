
class RentalRequest < ApplicationRecord
  attribute :id
  attribute :customer_name, :string, default: -> { '' }
  attribute :customer_info, :string, default: -> { '' }
  attribute :total_price, :integer, default: -> { 0 }
  attribute :pickup_date, :date, default: -> { '2020/1/1' }
  attribute :dropoff_date, :date, default: -> { '2020/1/1' }
  attribute :detail, :string, default: -> { '' }

  validates :customer_name, :customer_info, :total_price, :pickup_date, :dropoff_date, :detail, presence: true
  scope :by_id, lambda {|x| where(id: x)}

end