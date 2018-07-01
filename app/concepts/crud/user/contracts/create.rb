# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module User
    class Contracts::Create < Reform::Form
      feature Reform::Form::Dry

      property :email
      property :password, readable: false

      validation :default do
        required(:email).filled(:str?)
        required(:password).filled(:str?)
      end

      class << self
        def documentation
          {
            email: { required: true, type: "String", desc: "Email of the user" },
            password: { required: true, type: "String", desc: "Password of the user" }
          }
        end
      end
    end
  end
end
