# frozen_string_literal: true

module Types
  module Base
    class Field < GraphQL::Schema::Field
      argument_class Types::Base::Argument

      def initialize(*args, required_role: false, **kwargs, &block)
        @required_role = required_role
        super(*args, **kwargs, &block)
      end

      def visible?(context)
        # if `required_role:` was given, then require the current user to be an admin
        super && (@required_role ? check_role_requirement(context) : true)
      end

      private
        def check_role_requirement(context)
          return false unless context[:current_user].present?
          policy(context).field_visible_by?(@required_role, name)
        end

        def policy(context)
          parent_type = owner

          policy_class = "#{parent_type.name.demodulize}Policy".constantize
          policy_class.new(context[:current_user], nil)
        end
    end
  end
end
