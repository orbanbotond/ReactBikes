# frozen_string_literal: true

module Crud
  module Common
    module Operations
      class Read < Trailblazer::Operation
        step Model(::ApplicationRecord, :find_by)
        # step Trailblazer::Operation::Policy::Pundit(XY, :create?)
      end
    end
  end
end
