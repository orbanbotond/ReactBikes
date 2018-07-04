# frozen_string_literal: true

module Crud
  module Reservation
    module Operations
      class Update < Trailblazer::Operation
        step Model(::Reservation, :find_by)
        step Policy::Guard( ->(options, model:, **) { model.live? }, name: :live )

        step Nested(
          ::Crud::Common::Operations::Persist,
          input: -> (options, mutable_data:, runtime_data:, **) do
            runtime_data.merge(
              "model" => mutable_data["model"],
              "model.class" => ::Reservation,
              "contract.default.class" => ::Crud::Reservation::Contracts::Update
            )
          end
        )
        success :recalculate_average_of_bike

        def recalculate_average_of_bike(options, model:, params:, **)
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
end
