class Price < ActiveRecord::Base
  belongs_to :goods
  belongs_to :shop
end
