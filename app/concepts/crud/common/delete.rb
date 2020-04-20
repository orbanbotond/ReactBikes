# frozen_string_literal: true

module Crud
  module Common
    class Delete < Granite::Action
      allow_if { performer.present? }

      attribute :id, Integer
      attribute :ar_class, Symbol

      validates :id, presence: true
      validates :ar_class,
                presence: true,
                inclusion: { in: %i(user bike bike_model reservation) }

      private
        def execute_perform!(*)
          actual_performer = performer
          entity = Crud::Common::Read.as(actual_performer).new(attributes).perform
          entity.destroy
          entity
        end
    end
  end
end
