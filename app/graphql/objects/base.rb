module Objects
  class Base < GraphQL::Schema::Object
    field_class Types::BaseField
  end
end
