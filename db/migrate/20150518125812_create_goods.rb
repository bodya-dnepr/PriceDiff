class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.integer :product_property_id, index: true

      t.timestamps null: false
    end
  end
end
