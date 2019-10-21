module Types
  class User < Types::BaseObject
    description 'A user'

    field :id, ID, null: false
    field :email, String, null: false
    field :created_at, Lib::Scalars::DateTime, null: false
    field :updated_at, Lib::Scalars::DateTime, null: false
  end
end
