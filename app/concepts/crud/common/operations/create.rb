# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Create < Trailblazer::Operation
        step Model(ApplicationRecord, :new)

        step Nested(Persist)
      end
    end
  end
end
