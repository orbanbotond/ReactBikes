module Types
  class BikeType < Types::BaseObject
    description "A rentable bike"

    field :id, ID, null: false
    field :color, String, null: true,
          description: "The color of the bike"
    field :weight, Float, null: true,
          description: "The weight of a bike in kg"
    field :latitude, Float, null: true,
          description: "The latitude of the current position of the bike"
    field :longitude, Float, null: true,
          description: "The longitude of the current position of the bike"
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :average_rating, Float, null: true,
          description: "The average rating of the bike"
    field :model, BikeModelType, null: true,
          method: :bike_model,
          description: "The model of the bike"
    field :reservations, [BikeReservationType], null: true,
          description: "The reservations of the bike"
  end
end
