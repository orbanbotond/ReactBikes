# frozen_string_literal: true

module Mutations
  class DeleteBike < Mutations::BaseMutation
    argument :bike_id, ID, required: true, loads: ::Types::BikeType

    field :errors, [String], null: false

    def authorized?(**args)
      return false, { errors: ["Can't delete a bike with the current role"] } unless context[:current_user].admin?

      true
    end

    def resolve(bike:, **rest)
      if bike[0].destroy
        {
          errors: []
        }
      else
        {
          errors: ["An error occured."]
        }
      end
    end
  end
end
