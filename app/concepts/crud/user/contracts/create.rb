# frozen_string_literal: true

require "reform/form/dry"

module Crud
  module User
    class Contracts::Create < Reform::Form
      feature Reform::Form::Dry

      property :email
      property :password, readable: false

      validation :default do
        configure do
          predicates(::Common::Contracts::Predicates)
          config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")
        end

        required(:email).filled(:str?, :email?)
        required(:password).filled(:str?)
      end

      validation :unique, if: :default do
        configure do
          config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")

          def unique?(value)
            return false if ::User.exists?(email: value)

            true
          end
        end

        required(:email, &:unique?)
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
