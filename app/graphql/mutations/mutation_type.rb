class MutationType < Objects::Base
  field :userCreate, mutation: Users::Mutations::Create
end
