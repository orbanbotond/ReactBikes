# frozen_string_literal: true

module Types
  class MutationType < Types::Base::Object
    field :create_bike, mutation: ::Mutations::CreateBike
    field :update_bike, mutation: ::Mutations::UpdateBike
    field :delete_bike, mutation: ::Mutations::DeleteBike
    field :delete_user, mutation: ::Mutations::DeleteUser
    field :update_user, mutation: ::Mutations::UpdateUser
    field :create_user, mutation: ::Mutations::CreateUser
    field :create_reservation, mutation: ::Mutations::CreateReservation
    field :update_reservation, mutation: ::Mutations::UpdateReservation
  end
end
