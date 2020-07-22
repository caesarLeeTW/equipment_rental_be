class CreateEquipmentLists < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment_lists do |t|
      t.string :name
      t.string :description
      t.string :json_image_list
      t.timestamps
    end
  end
end
