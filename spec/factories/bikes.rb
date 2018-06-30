# frozen_string_literal: true

FactoryBot.define do
  factory :bike do
    color "MyString"
    weight "MyString"
    latitude "9.99"
    longitude "9.99"
    bike_model
  end
end
