# frozen_string_literal: true

require "reform/form/dry"

module Crud
  class Contracts::CreateBike < Reform::Form
    feature Reform::Form::Dry

    property :color
    property :weight
    property :latitude
    property :longitude
    property :bike_model_id

    validation :default do
      required( :color).filled(:str?, included_in?: Bike::COLORS)
      required( :weight).filled(:decimal?)
      required( :latitude).filled(:decimal?)
      required( :longitude).filled(:decimal?)
      required( :bike_model_id).filled(:int?)
    end

    class << self
      def documentation
        {
          color: { required: true, type: "String", desc: "Color for the bike" },
          weight: { required: true, type: "String", desc: "The weight of the bike" },
          latitude: { required: true, type: "Decimal", desc: "The latitude of the bike" },
          longitude: { required: true, type: "Decimal", desc: "The longitude of the bike" },
          bike_model_id: { required: true, type: "Integer", desc: "The FK reference to the BikeMode.id" }
        }
      end
    end
  end
end
