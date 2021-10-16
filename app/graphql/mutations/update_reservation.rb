# frozen_string_literal: true

module Mutations
  class UpdateReservation < Mutations::BaseMutation
    argument :rating, Integer, required: false
    argument :cancelled, Boolean, required: false
    argument :reservation_id, ID, required: true, loads: ::Types::BikeReservationType

    field :reservation, ::Types::BikeReservationType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      operation = back_end_operation(args)

      if operation.valid? && (model = operation.perform)
        {
          reservation: model,
          errors: [],
        }
      else
        {
          reservation: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def authorized?(**args)
      return false, { errors: ["Can't create the reservation with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def back_end_operation(reservation:, **args)
      @back_end_operation ||= Crud::Reservation::Update.as(context[:current_user]).new(args.merge(id: reservation[0].id))
    end
  end
end
