class ProductProperty < ActiveRecord::Base
  belongs_to :product
  has_many :goods
end
