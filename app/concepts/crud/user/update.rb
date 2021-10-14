# frozen_string_literal: true

module Crud
  module User
    class Update < Granite::Action
      allow_if { performer.present? && performer.admin? }

      attribute :id, Integer
      attribute :admin, Boolean
      attribute :email, String

      validates :id,
                presence: true

      private
        def execute_perform!(*)
          actual_performer = performer
          Crud::Common::Update.as(actual_performer).new(id: id, ar_class: :user, model_attributes: attributes).perform
        end
    end
  end
end
