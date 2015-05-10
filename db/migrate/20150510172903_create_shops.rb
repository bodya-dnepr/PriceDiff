class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.integer :city_id
      t.integer :store_chain_id
      t.decimal :lat
      t.decimal :lng
      t.string :sub_name

      t.timestamps null: false
    end
    add_index :shops, :city_id
    add_index :shops, :store_chain_id
    add_earthdistance_index :shops
  end
  def down
    remove_earthdistance_index :shops
    super
  end
end
