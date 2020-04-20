# frozen_string_literal: true

# abstract class
#-delegates to read sets
#-the model to the find entity
#-the calls the persist

#-sets the input to the model
#-saves the entity
module Crud
  module Common
    class Update < Granite::Action
      allow_if { performer.present? }

      attribute :id, Integer
      attribute :ar_class, Symbol
      attribute :model_attributes, Hash

      validates :model_attributes,
                presence: true
      validates :id, presence: true
      validates :ar_class,
                presence: true,
                inclusion: { in: %i(user bike bike_model reservation) }

      private
        def execute_perform!(*)
          actual_performer = performer
          model = Crud::Common::Read.as(actual_performer).new(attributes).perform
          Crud::Common::Persist.as(actual_performer).new(model: model, model_attributes: model_attributes.reject { |k, v|v.nil? }).perform
        end
    end
  end
end
