class Goods < ActiveRecord::Base
  belongs_to :product_property
  validates :name, :product_property_id, presence: true

  def full_name
    "#{product_property.product.name} #{name} (#{product_property.name})"
  end
end
