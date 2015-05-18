class Product < ActiveRecord::Base
  has_many :product_properties
  has_and_belongs_to_many :tags
  validates :name, presence: true
  validates :name, uniqueness: true
end
