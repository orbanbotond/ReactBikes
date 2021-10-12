# frozen_string_literal: true

module Types
  module Base
    class InputObject < GraphQL::Schema::InputObject
      argument_class Types::Base::Argument
    end
  end
end
