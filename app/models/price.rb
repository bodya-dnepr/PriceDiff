class Price < ActiveRecord::Base
  belongs_to :goods
  belongs_to :shop
  validates :amount, :goods_id, :shop_id, presence: true
end
