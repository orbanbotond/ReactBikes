# frozen_string_literal: true

module Crud
  module Common
    class Create < Granite::Action
      allow_if { performer.present? }

      attribute :ar_class, Symbol
      attribute :model_attributes, Hash

      validates :model_attributes,
                presence: true
      validates :ar_class,
                presence: true,
                inclusion: { in: %i(user bike bike_model reservation) }

      private
        def execute_perform!(*)
          classs = ar_class.to_s.classify.constantize
          model = classs.new
          actual_performer = performer
          Crud::Common::Persist.as(actual_performer).new(model: model, model_attributes: model_attributes).perform
        end
    end
  end
end
