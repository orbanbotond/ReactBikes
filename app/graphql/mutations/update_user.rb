# frozen_string_literal: true

module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :password, String, required: false
    argument :admin, Boolean, required: false
    argument :email, String, required: false
    argument :user_id, ID, required: true, loads: ::Types::User

    field :user, ::Types::User, null: true
    field :errors, [String], null: false

    def resolve(**args)
      operation = back_end_operation(args)

      if operation.valid? && (updated_model = operation.perform)
        {
          user: updated_model,
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
      return false, { errors: ["Can't update the user with the current role"] } unless back_end_operation(args).allowed?

      true
    end

    def back_end_operation(user:, **args)
      params = args.merge(id: user.first.id)
      @back_end_operation ||= Crud::User::Update.as(context[:current_user]).new(params)
    end
  end
end
