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
