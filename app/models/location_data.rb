class LocationData < ApplicationRecord

  has_one :current
  has_many :dailies
  has_many :hourlies

end
