class CreateStoreChains < ActiveRecord::Migration
  def change
    create_table :store_chains do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
