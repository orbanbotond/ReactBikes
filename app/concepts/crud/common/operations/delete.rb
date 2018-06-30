# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Delete < Trailblazer::Operation
        step Model(::ApplicationRecord, :find_by)
        # step Trailblazer::Operation::Policy::Pundit(XY, :create?)
        step :destroy

        def destroy(options, model:, **)
        	model.destroy
        end
      end
    end
  end
end
