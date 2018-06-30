# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module Reservation
    class Contracts::Update < Reform::Form
      feature Reform::Form::Dry

      property :cancelled
      property :rating

      validation :default do
        optional( :cancelled).maybe(:bool?)
        optional( :rating).maybe(:int?, included_in?: 1..5)
      end

      validation :only_one, if: :default, with: { form: true } do
        configure do
          config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")

          def only_one?(value)
            return false if options[:form].changed.keys.count != 1
            
            true
          end
        end

        required(:cancelled, &:only_one?)
        required(:rating, &:only_one?)
      end

      class << self
        def documentation
          {
            cancelled: { required: false, type: "Boolean", desc: "If we want to cancell" },
            rating: { required: false, type: "Integer", desc: "1..5" }
          }
        end
      end
    end
  end
end
