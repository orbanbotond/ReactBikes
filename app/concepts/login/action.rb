# frozen_string_literal: true

module Login
  class Action < Granite::Action
    allow_if { performer.present? }

    attribute :email, String
    attribute :password, String

    validates :email,
              presence: true,
              format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true

    validate :validate_credentials, if: -> { errors.empty? }

    private
      def execute_perform!(*)
        @user.hashed_session_token = User.pwd_hash(@user.session_token)
        @user.save

        @user
      end

      def validate_credentials
        @user ||= User.find_by(email: email)

        # This is a humanistic error but open path to phishing attacts.
        unless @user.present?
          errors.add(:email, "Email is nonexistent")
          return
        end

        errors.add(:password, "email/pwd don't match") unless @user.valid_password?(password)
      end
  end
end
