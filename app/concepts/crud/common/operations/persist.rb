# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Persist < Trailblazer::Operation
        # step Trailblazer::Operation::Policy::Pundit(XY, :create?)

        step Contract::Build()
        step Contract::Validate()  
        step Contract::Persist()
      end
    end
  end
end
