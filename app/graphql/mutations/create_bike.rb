# frozen_string_literal: true

module Mutations
  class CreateBike < Mutations::BaseMutation
    argument :color, ::Types::BikeColorsEnum, required: true
    argument :weight, Float, required: true
    argument :latitude, Float, required: true
    argument :longitude, Float, required: true
    argument :bike_model_id, ID, required: true

    field :bike, ::Types::BikeType, null: true
    field :errors, [String], null: false

    def authorized?(**args)
      return false, { errors: ["Can't create a bike with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def resolve(**rest)
      operation = back_end_operation(rest)

      if operation.valid? && (bike = operation.perform)
        {
          bike: bike,
          errors: [],
        }
      else
        {
          bike: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def back_end_operation(**args)
      params = args.merge(bike_model_id: GraphQL::Schema::UniqueWithinType.decode(args[:bike_model_id])[1])
      @back_end_operation ||= Crud::Bike::Create.as(context[:current_user]).new(params)
    end
  end
end
