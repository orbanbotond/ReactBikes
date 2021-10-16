# frozen_string_literal: true

module Crud
  module Reservation
    class Create < Granite::Action
      allow_if do
        ::ReservationPolicy.new(performer, model).create?
      end

      attribute :start_date, Date
      attribute :end_date, Date
      attribute :bike_id, Integer
      attribute :current_user, Object

      validates :current_user, presence: true
      validates :start_date, presence: true
      validates :end_date, presence: true
      validates :bike_id, presence: true
      validate :foreign_key_exists
      validate :start_before_end
      validate :start_date_is_in_future
      validate :end_date_is_in_future

      private
        def foreign_key_exists
          return unless bike_id.present?

          errors.add(:bike_id, "Model doesn't exists") unless ::Bike.exists?(bike_id)
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

        def model
          return @reservation if @reservation.present?

          @reservation = ::Reservation.new
          @reservation.user = current_user
        end

        def execute_perform!(*)
          Crud::Common::Persist.as(performer).new(model: model, model_attributes: attributes.except("current_user")).perform
        end
    end
  end
end
