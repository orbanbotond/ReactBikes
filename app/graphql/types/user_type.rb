module Types
  class UserType < Types::BaseObject
    description "A user reservation"

    field :email, String, null: false,
          description: "The user who reserved the bike"
  end
end