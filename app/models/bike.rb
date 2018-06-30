# frozen_string_literal: true

class Bike < ApplicationRecord
  has_many :reservations
  belongs_to :bike_model

  COLORS = ["red", "blue", "magenta", "white", "black"].freeze
end
