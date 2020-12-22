class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :postal_code,     null:false
      t.integer :prefectural_id, nul:false
      t.string :city,            null:false
      t.string :street,          null:false
      t.references :buyer,       foreign_key: true
      t.string :building
      t.string :tel,             null:false
      t.timestamps
    end
  end
end
