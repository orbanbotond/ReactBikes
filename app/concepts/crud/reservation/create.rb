# frozen_string_literal: true

module Crud
  module Reservation
    class Create < Granite::Action
      allow_if { performer.present? }

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

      class << self
        def documentation
          {
            start_date: { required: true, type: "Date", desc: "The start date" },
            end_date: { required: true, type: "Date", desc: "The end date" },
            bike_id: { required: true, type: "Integer", desc: "The FK reference to the Bike.id" }
          }
        end
      end

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

        def execute_perform!(*)
          reservation = ::Reservation.new
          reservation.user = current_user
          actual_performer = performer
          Crud::Common::Persist.as(actual_performer).new(model: reservation, model_attributes: attributes.except("current_user")).perform
        end
    end
  end
end
