# frozen_string_literal: true

FactoryBot.define do
  factory :bike do
    color { ::Bike::COLORS.last }
    weight { 3.4 }
    latitude { "9.99" }
    longitude { "9.99" }
    bike_model
  end
end
