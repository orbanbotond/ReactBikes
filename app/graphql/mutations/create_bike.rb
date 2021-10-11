module Mutations
  class CreateBike < Mutations::BaseMutation
    argument :color, ::Types::BikeColorsEnum, required: true
    argument :weight, Float, required: true
    argument :latitude, Float, required: true
    argument :longitude, Float, required: true
    argument :bike_model_id, Integer, required: true

    field :bike, ::Types::BikeType, null: true
    field :errors, [String], null: false

    def resolve(**rest)
      operation = Crud::Bike::Create.as(context[:current_user]).new(arguments)
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