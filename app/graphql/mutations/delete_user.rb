# frozen_string_literal: true

module Mutations
  class DeleteUser < Mutations::BaseMutation
    argument :user_id, ID, required: true, loads: ::Types::User

    field :errors, [String], null: false

    def authorized?(**args)
      return false, { errors: ["Can't delete a user with the current role"] } unless context[:current_user].admin?

      true
    end

    def resolve(user:, **rest)
      if user[0].destroy
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
