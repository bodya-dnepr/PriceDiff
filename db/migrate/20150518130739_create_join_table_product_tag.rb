class CreateJoinTableProductTag < ActiveRecord::Migration
  def change
    create_join_table :products, :tags do |t|
      t.index [:tag_id, :product_id]
    end
    add_index :products_tags, [:product_id, :tag_id], unique: true
  end
end
