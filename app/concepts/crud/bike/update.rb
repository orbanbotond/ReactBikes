# frozen_string_literal: true

module Crud
  module Bike
    class Update < Granite::Action
      allow_if { performer.present? && performer.admin? }

      attribute :id, Integer
      attribute :color, String
      attribute :weight, BigDecimal
      attribute :latitude, BigDecimal
      attribute :longitude, BigDecimal
      attribute :bike_model_id, Integer

      validates :color,
                presence: true,
                inclusion: { in: ::Bike::COLORS },
                if: -> { color.present? }
      validates :id,
                presence: true
      validate :foreign_key_exists

      private
        def execute_perform!(*)
          actual_performer = performer
          Crud::Common::Update.as(actual_performer).new(id: id, ar_class: :bike, model_attributes: attributes).perform
        end

        def foreign_key_exists
          return unless bike_model_id.present?

          errors.add(:bike_model_id, "Model doesn't exists") unless BikeModel.exists?(bike_model_id)
        end
    end
  end
end
