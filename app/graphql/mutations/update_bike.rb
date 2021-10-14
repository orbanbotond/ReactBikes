# frozen_string_literal: true

module Mutations
  class UpdateBike < Mutations::BaseMutation
    argument :color, ::Types::BikeColorsEnum, required: false
    argument :weight, Float, required: false
    argument :latitude, Float, required: false
    argument :longitude, Float, required: false
    argument :bike_model_id, ID, required: false
    argument :bike_id, ID, required: true, loads: ::Types::BikeType

    field :bike, ::Types::BikeType, null: true
    field :errors, [String], null: false

    def resolve(**args)
      operation = back_end_operation(args)

      if operation.valid? && (updated_bike = operation.perform)
        {
          bike: updated_bike,
          errors: [],
        }
      else
        {
          bike: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def authorized?(**args)
      return false, { errors: ["Can't update the bike with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def back_end_operation(bike:, **args)
      return @back_end_operation if @back_end_operation.present?

      params = args.merge(id: bike.first.id)
      params = params.merge(bike_model_id: GraphQL::Schema::UniqueWithinType.decode(args[:bike_model_id])[1]) if args[:bike_model_id].present?
      @back_end_operation ||= Crud::Bike::Update.as(context[:current_user]).new(params)
    end
  end
end
