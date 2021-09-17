module Types
  class BikeReservationType < Types::Base::Object
    description "A bike reservation"

    field :start_date, GraphQL::Types::ISO8601DateTime, null: false,
          description: "The start_date of the reservation"
    field :end_date, GraphQL::Types::ISO8601DateTime, null: false,
          description: "The end date of the reservation"
    field :cancelled, Boolean, null: true,
          description: "The status of the reservation"
    field :user, UserType, null: false,
          description: "The user who reserved the bike"
    field :bike, BikeType, null: false,
          description: "The bike which is reserved"
  end
end