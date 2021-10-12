# frozen_string_literal: true

class Bike < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :bike_model
  has_one_attached :picture

  scope :by_color, ->(color) { where(color: color) }
  scope :red, -> { by_color("red") }

  COLORS = %w(red blue magenta white black).freeze
end
