# frozen_string_literal: true

module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :password, String, required: false
    argument :admin, Boolean, required: false
    argument :email, String, required: false

    field :user, ::Types::User, null: true
    field :errors, [String], null: false

    def resolve(**args)
      operation = back_end_operation(args)

      if operation.valid? && (model = operation.perform)
        {
          user: model,
          errors: [],
        }
      else
        {
          user: nil,
          errors: operation.errors.full_messages
        }
      end
    end

    def authorized?(**args)
      return false, { errors: ["Can't create the user with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def back_end_operation(**args)
      @back_end_operation ||= Crud::User::Create.as(context[:current_user]).new(args)
    end
  end
end
