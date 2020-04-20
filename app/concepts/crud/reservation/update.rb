# frozen_string_literal: true

module Crud
  module Reservation
    class Update < Granite::Action
      allow_if { performer.present? }

      attribute :cancelled, Boolean
      attribute :rating, Integer
      attribute :id, Integer

      validates :rating,
                inclusion: { in: 1..5 },
                if: -> { rating.present? }
      validates :id, presence: true
      validate :only_rating_or_cancelled

      private
        def only_rating_or_cancelled
          msg = "Only accept rating or cancelled"
          if cancelled && rating.present?
            errors.add(:rating, msg)
            errors.add(:cancelled, msg)
          end
        end

        def execute_perform!(*)
          actual_performer = performer
          model = Crud::Common::Read.as(actual_performer).new(id: id, ar_class: :reservation).perform
          Crud::Common::Persist.as(actual_performer).new(model: model, model_attributes: attributes).perform
          recalculate_average_of_bike(model: model)
          model
        end

        def recalculate_average_of_bike(model:)
          reservations = ::Reservation.where(bike_id: model.bike_id)
          relevant_reservations = reservations.pluck(:rating).compact
          return unless relevant_reservations.present?

          average_rating = relevant_reservations.sum / relevant_reservations.count
          bike = model.bike
          bike.average_rating = average_rating
          bike.save
        end
    end
  end
end
