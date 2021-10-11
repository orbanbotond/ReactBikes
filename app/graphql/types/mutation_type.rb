module Types
  class MutationType < Types::Base::Object
    field :create_bike, mutation: ::Mutations::CreateBike
  end
end
