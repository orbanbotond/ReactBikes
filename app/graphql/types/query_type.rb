# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include Resolvers::Bikes
    include Resolvers::Users

    field :available_bikes, BikeType.connection_type, null: false, connection: true,
      description: "A list of available bikes within the search parameters" do
      argument :start_date, GraphQL::Types::ISO8601Date, required: true
      argument :end_date, GraphQL::Types::ISO8601Date, required: true
      argument :color, String, required: false
      argument :bike_model_id, ID, required: false
      argument :weight, Float, required: false
      argument :rating, Integer, required: false
    end
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
    def available_bikes(**args)
      Queries::AvailableBikes.as(context[:current_user]).new(args).perform
    end
  end
end
