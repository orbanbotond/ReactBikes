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

    def resolve(bike:, **rest)
      params = arguments.merge(id: bike.first.id)

      operation = Crud::Bike::Update.as(context[:current_user]).new(params)
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
  end
end
