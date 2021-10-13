# frozen_string_literal: true

module Types
  class MutationType < Types::Base::Object
    field :create_bike, mutation: ::Mutations::CreateBike
    field :update_bike, mutation: ::Mutations::UpdateBike
    field :delete_bike, mutation: ::Mutations::DeleteBike
  end
end
