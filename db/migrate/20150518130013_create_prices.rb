class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.decimal :amount
      t.integer :goods_id, index: true
      t.references :shop, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
