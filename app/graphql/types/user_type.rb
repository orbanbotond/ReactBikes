module Types
  class UserType < Types::Base::Object
    description "A user reservation"

    field :email, String, null: false,
          description: "The user who reserved the bike"
  end
end