module Types
  class MutationType < Types::Base::Object
    field :create_bike, mutation: ::Mutations::CreateBike
    field :update_bike, mutation: ::Mutations::UpdateBike
  end
end
