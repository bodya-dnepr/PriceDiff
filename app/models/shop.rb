class Shop < ActiveRecord::Base
  belongs_to :city
  belongs_to :store_chain
  acts_as_geolocated

  validates :city_id, :store_chain_id, presence: true

  def name
    "#{store_chain.name} #{sub_name}".squish
  end

  def location
    Hash[lat: lat, lng: lng]
  end

  def location?
    !lat.blank? and !lng.blank?
  end
end
