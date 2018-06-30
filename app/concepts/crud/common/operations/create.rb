# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Create < Trailblazer::Operation
        step Model(ApplicationRecord, :new)

        step Nested(
          Persist,
          input: -> (options, mutable_data:, runtime_data:, **) do
            runtime_data.merge("model" => mutable_data["model"])
          end
        )
      end
    end
  end
end
