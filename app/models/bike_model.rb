# frozen_string_literal: true

class BikeModel < ApplicationRecord
  has_many :bikes
  has_many :red_bikes, -> { red }, class_name: "Bike"
end
