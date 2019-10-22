# frozen_string_literal: true

FactoryBot.define do
  factory :reservation do
    start_date { 2.days.from_now.to_datetime }
    end_date { 3.days.from_now.to_datetime }
    rating { 1 }
    cancelled { false }
    user
    bike
  end
end
