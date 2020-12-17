class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title,                  null:false, default: ""
      t.text :explanation,              null:false
      t.integer :category_id,          null:false
      t.integer :product_condition_id, null:false
      t.integer :delivery_fee_id,      null:false
      t.integer :prefectural_id,        null:false
      t.integer :day_to_ship_id,        null:false
      t.integer :price,                 null:false
      t.references :user,               foreign_key: true
      t.timestamps
    end
  end
end
