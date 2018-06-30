# frozen_string_literal: true

module Queries
  module Operations
    class AvailableBikes < Trailblazer::Operation
      step :build_contract
      step Contract::Validate()

      step :search

      def build_contract(options, **)
        options["contract.default"] = ::Queries::Contracts::AvailableBikes.new({})
      end

      def search(options, params:, **)
        start_date = params[:start_date]
        end_date = params[:end_date]

        unavailable_reservations = date_wrap(end_date).or(date_wrap(start_date))
        available_bikes = ::Bike.where.not(id: unavailable_reservations.pluck(:bike_id))

        available_bikes = available_bikes.where(color: params[:color]) if params[:color].present?
        available_bikes = available_bikes.where("weight < ?", params[:weight]) if params[:weight].present?
        available_bikes = available_bikes.where(bike_model_id: params[:bike_model_id]) if params[:bike_model_id].present?
        options["model"] = available_bikes
      end

      def date_wrap(date)
        ::Reservation.where("start_date < ?", date)
          .where("end_date > ?", date)
      end
    end
  end
end
