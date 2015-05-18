class ProductProperty < ActiveRecord::Base
  belongs_to :product
  has_many :goods
  validates :name, :product_id, presence: true
  validates :name, uniqueness: {scope: :product_id}
end
