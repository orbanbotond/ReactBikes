# frozen_string_literal: true

#-sets the input to the model
#-saves the entity
module Crud
  module Common
    class Persist < Granite::Action
      allow_if { performer.present? }

      attribute :model, Object
      attribute :model_attributes, Hash

      validates :model,
                presence: true

      validates :model_attributes,
                presence: true

      private
        def execute_perform!(*)
          model.attributes = model_attributes
          model.save!
          model
        end
    end
  end
end
