# frozen_string_literal: true

require "reform/form/dry"

module Login
  class Contracts::Default < Reform::Form
    feature Reform::Form::Dry

    def initialize(_options)
      super(OpenStruct.new)
    end

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

    validation :matches_pwd, if: :default, with: { form: true } do
      configure do
        config.messages_file = File.join(Rails.root.to_s, "config", "locales", "en.yml")

        def matches_pwd?(value)
          user = User.find_by(email: options[:form].email)

          return false if user.blank?
          return false if !user.valid_password?(value)

          true
        end
      end

      required(:password, &:matches_pwd?)
    end

    class << self
      def documentation
        {
          email: { required: true, type: "String", desc: "The email" },
          password: { required: true, type: "String", desc: "The password" }
        }
      end
    end
  end
end
