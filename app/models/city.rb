class City < ActiveRecord::Base
  belongs_to :country
  has_many :shops
  has_many :store_chains, through: :shops
  validates :name, :country_id, presence: true
  validates :name, uniqueness: true
end
