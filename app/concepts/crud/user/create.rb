module Crud
  module User
    class Create < Granite::Action
      allow_if { performer.present? }

      attribute :email, String
      attribute :password, String

      validates :email,
                presence: true

      validates :password,
                presence: true

      validate :email_uniqueness

      private
      def execute_perform!(*)
        actual_performer = performer
        Crud::Common::Create.as(actual_performer).new(ar_class: :user, model_attributes: attributes).perform
      end

      def email_uniqueness
        errors.add(:email, "Is already taken") unless ::User.find_by(email: email).blank?
      end
    end
  end
end
