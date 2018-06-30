# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Update < Trailblazer::Operation
        step Model(::ApplicationRecord, :find_by)

        step Nested( 
          ::Crud::Common::Operations::Persist,
          input: -> (options, mutable_data:, runtime_data:, **) do
            runtime_data.merge("model"=> mutable_data["model"])
          end
        )
      end
    end
  end
end
