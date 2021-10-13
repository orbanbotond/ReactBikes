# frozen_string_literal: true

require_relative "pagination/active_record_relation_connection"

class ToptalReactBikesSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  use GraphQL::Batch

  # Union and Interface Resolution
  def self.resolve_type(abstract_type, obj, ctx)
    abstract_type
  end

  # Relay-style Object Identification:

  # Return a string UUID for `object`
  def self.id_from_object(object, type_definition, query_ctx)
    # Here's a simple implementation which:
    # - joins the type name & object.id
    # - encodes it with base64:
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  end

  # Given a string UUID, find the object
  def self.object_from_id(id, query_ctx)
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    type_name.constantize.where(id: item_id)
  end
end
