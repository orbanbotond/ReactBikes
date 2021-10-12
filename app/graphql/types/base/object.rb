# frozen_string_literal: true

module Types
  module Base
    class Object < GraphQL::Schema::Object
      edge_type_class(Types::Base::Edge)
      connection_type_class(::Connections::TotalConnection)
      field_class Types::Base::Field

      def id
        ToptalReactBikesSchema.id_from_object(object, object.class, context)
      end
    end
  end
end
