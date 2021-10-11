module Mutations
  class UpdateBike < Mutations::BaseMutation
    argument :color, ::Types::BikeColorsEnum, required: false
    argument :weight, Float, required: false
    argument :latitude, Float, required: false
    argument :longitude, Float, required: false
    argument :bike_model_id, Integer, required: false
    argument :bikeId, Integer, required: true

    field :bike, ::Types::BikeType, null: true
    field :errors, [String], null: false

    def resolve(bikeId:, **rest)
      operation = Crud::Bike::Update.as(context[:current_user]).new(arguments.merge(id: bikeId))
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