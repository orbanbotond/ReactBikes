# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module User
    class Contracts::Update < Reform::Form
      feature Reform::Form::Dry

      property :admin

      validation :default do
        required(:admin).filled(:bool?)
      end

      class << self
        def documentation
          {
            admin: { required: true, type: "String", desc: "Specifiying that the user is admin or not." }
          }
        end
      end
    end
  end
end
