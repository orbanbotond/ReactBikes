# frozen_string_literal: true

module Signup
  class Action < Granite::Action
    self._policies_strategy = AlwaysAllowStrategy

    attribute :email, String
    attribute :password, String

    validates :email,
              presence: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true

    validate :email_is_unique, if: -> { errors.empty? }

    private
      def execute_perform!(*)
        user = User.new(attributes)
        user.hashed_password = User.pwd_hash(password)
        user.save
        user
      end

      def email_is_unique
        errors.add(:email, "Email is already taked") unless User.find_by(email: email).blank?
      end
  end
end
