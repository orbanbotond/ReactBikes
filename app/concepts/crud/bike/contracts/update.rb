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
      property :bike_model_id

      validation :default do
        optional(:color).maybe(:str?, included_in?: ::Bike::COLORS)
        optional(:weight).maybe(:decimal?)
        optional(:latitude).maybe(:decimal?)
        optional(:longitude).maybe(:decimal?)
        optional(:bike_model_id).maybe(:int?)
      end

      validation :foreign_key_exists, if: :default, with: { form: true } do
        configure do
          config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")

          def foreign_key_exists?(value)
            return true unless value.present?

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
            color: { required: false, type: "String", desc: "Color for the bike" },
            weight: { required: false, type: "float", desc: "The weight of the bike" },
            latitude: { required: false, type: "float", desc: "The latitude of the bike" },
            longitude: { required: false, type: "float", desc: "The longitude of the bike" },
            bike_model_id: { required: false, type: "Integer", desc: "The FK reference to the BikeMode.id" }
          }
        end
      end
    end
  end
end
