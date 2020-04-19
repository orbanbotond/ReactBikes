# frozen_string_literal: true

module Crud
  module Common
    class Read < Granite::Action
      allow_if { performer.present? }

      attribute :id, Integer
      attribute :ar_class, Symbol

      validates :id, presence: true
      validates :ar_class,
                presence: true,
                inclusion: { in: %i(user bike bike_model reservation) }

    private
      def execute_perform!(*)
        classs = ar_class.to_s.classify.constantize
        classs.find(id)
      end
    end
  end
end
