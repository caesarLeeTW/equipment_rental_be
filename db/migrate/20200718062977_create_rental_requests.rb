
class CreateRentalRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :rental_requests do |t|
      t.string :customer_name
      t.string :customer_info
      t.integer :total_price
      t.date :pickup_date
      t.date :dropoff_date
      t.string :detail

      t.timestamps
    end
  end
end
