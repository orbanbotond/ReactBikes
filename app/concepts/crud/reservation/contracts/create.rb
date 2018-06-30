# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module Reservation
    class Contracts::Create < Reform::Form
      feature Reform::Form::Dry

      property :start_date
      property :end_date
      property :bike_id

      validation :default do
        required( :start_date).filled(:date_time?, gteq?: Time.zone.now)
        required( :end_date).filled(:date_time?, gteq?: Time.zone.now)
        required( :bike_id).filled(:int?)
      end

      validation :start_before_end, if: :default, with: { form: true } do
        configure do
          config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")

          def start_before_end?(value)
            return false if options[:form].end_date <= value
            
            true
          end
        end

        required(:start_date, &:start_before_end?)
      end

      class << self
        def documentation
          {
            start_data: { required: true, type: "Date", desc: "The start date" },
            end_date: { required: true, type: "Date", desc: "The end date" },
            bike_id: { required: true, type: "Integer", desc: "The FK reference to the Bike.id" }
          }
        end
      end
    end
  end
end
