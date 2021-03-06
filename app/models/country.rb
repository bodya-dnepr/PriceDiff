class Country < ActiveRecord::Base
  has_many :cities
  validates :name, presence: true
  validates :name, uniqueness: true
end
