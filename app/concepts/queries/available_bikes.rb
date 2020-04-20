# frozen_string_literal: true

module Queries
  class AvailableBikes < Granite::Action
    allow_if { performer.present? }

    attribute :start_date, Date
    attribute :end_date, Date
    attribute :color, String
    attribute :weight, BigDecimal
    attribute :bike_model_id, Integer
    attribute :rating, Integer

    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :color,
              inclusion: { in: ::Bike::COLORS },
              if: -> { color.present? }
    validates :rating,
              inclusion: { in: 1..5 },
              if: -> { rating.present? }
    validate :foreign_key_exists
    validate :start_before_end
    validate :start_date_is_in_future
    validate :end_date_is_in_future

    private
      def foreign_key_exists
        return unless bike_model_id.present?

        errors.add(:bike_model_id, "Model doesn't exists") unless BikeModel.exists?(bike_model_id)
      end

      def start_date_is_in_future
        return unless start_date.present?

        errors.add(:start_date, "Start date must be in the future") unless start_date > Date.today
      end

      def end_date_is_in_future
        return unless end_date.present?

        errors.add(:end_date, "End date must be in the future") unless end_date > Date.today
      end

      def start_before_end
        return unless start_date.present?
        return unless end_date.present?

        errors.add(:start_date, "Start date must be before the end date") unless start_date < end_date
      end

      def execute_perform!(*)
        search
      end

      def search
        unavailable_reservations = date_wrap(end_date).or(date_wrap(start_date))
        available_bikes = ::Bike.where.not(id: unavailable_reservations.pluck(:bike_id))

        available_bikes = available_bikes.where(color: color) if color.present?
        available_bikes = available_bikes.where("weight < ?", weight) if weight.present?
        available_bikes = available_bikes.where(bike_model_id: bike_model_id) if bike_model_id.present?
        available_bikes = available_bikes.where("average_rating >= ?", rating) if rating.present?
        available_bikes
      end

      def date_wrap(date)
        ::Reservation.where("start_date < ?", date)
                      .where("end_date > ?", date)
      end
  end
end
