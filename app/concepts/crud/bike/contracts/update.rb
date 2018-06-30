# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module Bike
    class Contracts::Update < Reform::Form
      feature Reform::Form::Dry

      property :color
      property :weight
      property :latitude
      property :longitude

      validation :default do
        optional(:color).maybe(:str?, included_in?: ::Bike::COLORS)
        optional(:weight).maybe(:decimal?)
        optional(:latitude).maybe(:decimal?)
        optional(:longitude).maybe(:decimal?)
      end

      class << self
        def documentation
          {
            color: { required: false, type: "String", desc: "Color for the bike" },
            weight: { required: false, type: "String", desc: "The weight of the bike" },
            latitude: { required: false, type: "Decimal", desc: "The latitude of the bike" },
            longitude: { required: false, type: "Decimal", desc: "The longitude of the bike" },
            bike_model_id: { required: false, type: "Integer", desc: "The FK reference to the BikeMode.id" }
          }
        end
      end
    end
  end
end