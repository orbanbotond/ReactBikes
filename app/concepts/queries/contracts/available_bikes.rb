# frozen_string_literal: true

require "reform/form/dry"

module Queries
  class Contracts::AvailableBikes < Reform::Form
    feature Reform::Form::Dry

    def initialize(_options)
      super(OpenStruct.new)
    end

    property :start_date
    property :end_date
    property :color
    property :weight
    property :bike_model_id
    property :rating

    validation :default do
      required(:start_date).filled(:date_time?, gteq?: Time.zone.now)
      required(:end_date).filled(:date_time?, gteq?: Time.zone.now)

      optional(:rating).maybe(:int?, included_in?: 1..5)
      optional(:color).maybe(:str?, included_in?: ::Bike::COLORS)
      optional(:weight).maybe(:decimal?)
      optional(:bike_model_id).maybe(:int?)
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
          start_date: { required: true, type: "String", desc: "The start date of the rental" },
          end_date: { required: true, type: "String", desc: "The end date of the rental" },
          color: { required: false, type: "String", desc: "The color of the bike" },
          weight: { required: false, type: "Decimal", desc: "The maximum weight of the bike. " },
          bike_model_id: { required: false, type: "Integer", desc: "The FK reference to the BikeModel.id" },
          rating: { required: false, type: "Integer", desc: "Minimum Rating of the Bike." }
        }
      end
    end
  end
end
