# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include Resolvers::Bikes
    include Resolvers::Users

    field :bikes, BikeType.connection_type, null: false, connection: true,
      description: "A list of all bikes" do
      argument :id, ID, required: false
    end
    field :users, ::Types::User.connection_type, null: false, connection: true,
      description: "A list of all users" do
      argument :id, ID, required: false
    end
    field :bike_models, [::Types::BikeModelType],
      null: false, 
      description: "A list of all bike models"

    def bike_models
      BikeModel.all
    end
  end
end
