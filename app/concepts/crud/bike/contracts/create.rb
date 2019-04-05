# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module Bike
    class Contracts::Create < Reform::Form
      feature Reform::Form::Dry

      property :color
      property :weight
      property :latitude
      property :longitude
      property :bike_model_id

      validation :default do
        required(:color).filled(:str?, included_in?: ::Bike::COLORS)
        required(:weight).filled(:decimal?)
        required(:latitude).filled(:decimal?)
        required(:longitude).filled(:decimal?)
        required(:bike_model_id).filled(:int?)
      end

      validation :foreign_key_exists, if: :default, with: { form: true } do
        configure do
          config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")

          def foreign_key_exists?(value)
            model = BikeModel.exists? value

            return false if model.blank?

            true
          end
        end

        required(:bike_model_id, &:foreign_key_exists?)
      end

      class << self
        def documentation
          {
            color: { required: true, type: "String", desc: "Color for the bike" },
            weight: { required: true, type: "float", desc: "The weight of the bike" },
            latitude: { required: true, type: "float", desc: "The latitude of the bike" },
            longitude: { required: true, type: "float", desc: "The longitude of the bike" },
            bike_model_id: { required: true, type: "Integer", desc: "The FK reference to the BikeMode.id" },
          }
        end
      end
    end
  end
end
