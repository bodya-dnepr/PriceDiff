class StoreChain < ActiveRecord::Base
  has_many :shops
  has_many :cities, through: :shops
  validates :name, presence: true
end
