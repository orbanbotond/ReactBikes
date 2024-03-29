# frozen_string_literal: true

module Types
  module Base
    # class Connection < Types::Base::Object
    class Connection < GraphQL::Schema::Object
      # add `nodes` and `pageInfo` fields, as well as `edge_type(...)` and `node_nullable(...)` overrides
      include GraphQL::Types::Relay::ConnectionBehaviors
    end
  end
end
