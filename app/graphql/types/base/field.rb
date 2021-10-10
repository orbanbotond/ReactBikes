module Types
  module Base
    class Field < GraphQL::Schema::Field
      argument_class Types::Base::Argument

      def initialize(*args, require_admin: false, **kwargs, &block)
        @require_admin = require_admin
        super(*args, **kwargs, &block)
      end

      def visible?(context)
        # if `require_admin:` was given, then require the current user to be an admin
        super && (@require_admin ? context[:current_user].try(:'admin?') : true)
      end
    end
  end
end
