class MutationType < Lib::Objects::Base
  field :userCreate, mutation: Users::Mutations::Create
end
