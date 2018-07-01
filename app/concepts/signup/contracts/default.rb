# frozen_string_literal: true

require "reform/form/dry"

module Signup
  class Contracts::Default < Reform::Form
    feature Reform::Form::Dry

    property :email
    property :password

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
          return false if User.exists?(email: value)

          true
        end
      end

      required(:email, &:unique?)
    end

    class << self
      def documentation
        {
          email: { required: true, type: "String", desc: "The email" },
          password: { required: true, type: "String", desc: "The password"}
        }
      end
    end
  end
end
