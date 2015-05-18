class Goods < ActiveRecord::Base
  belongs_to :product_property
  validates :name, :product_property_id, presence: true
end
