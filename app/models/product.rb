class Product < ActiveRecord::Base
  has_many :product_properties
  has_and_belongs_to_many :tags
end
