# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "MyString@gmail.com" }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
