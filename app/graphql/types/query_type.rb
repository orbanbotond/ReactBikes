module Types
  class QueryType < Types::Base::Object
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :bikes, [BikeType], null: false,
      description: "A list of all bikes"

    def bikes
      Bike.all
    end
  end
end
