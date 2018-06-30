class Bike < ApplicationRecord
  has_many :reservations
  belongs_to :bike_model
end
