# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Update < Trailblazer::Operation
        step Model(::ApplicationRecord, :find_by)

        step Nested(::Crud::Common::Operations::Persist)
      end
    end
  end
end
