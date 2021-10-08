module Types
  class UserType < Types::Base::Object
    description "A user reservation"

    field :id, ID, null: false
    field :email, String, null: false,
          description: "The email of the user"
    field :admin, Boolean, null: false,
          description: "Tells us if the user is an admin or not"

    field :reservations, [BikeReservationType], null: true,
          description: "The reservations of the user"

    def reservations
      ::BatchLoaders::AssociationLoader.for(User, :reservations).load(object)
    end
  end
end