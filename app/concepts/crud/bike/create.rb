# frozen_string_literal: true

module Crud
  module Bike
    class Create < Granite::Action
      # allow_if { use BikePolicy... }
      allow_if { performer.present? && performer.admin? }

      attribute :color, String
      attribute :weight, BigDecimal
      attribute :latitude, BigDecimal
      attribute :longitude, BigDecimal
      attribute :bike_model_id, Integer

      validates :color,
                presence: true,
                inclusion: { in: ::Bike::COLORS }

      validates :weight,
                presence: true

      validates :latitude,
                presence: true

      validates :longitude,
                presence: true

      validates :bike_model_id,
                presence: true

      validate :foreign_key_exists

      private
        def execute_perform!(*)
          actual_performer = performer
          Crud::Common::Create.as(actual_performer).new(ar_class: :bike, model_attributes: attributes).perform
        end

        def foreign_key_exists
          errors.add(:bike_model_id, "Model doesn't exists") unless BikeModel.exists?(bike_model_id)
        end
    end
  end
end
