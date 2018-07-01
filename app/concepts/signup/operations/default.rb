# frozen_string_literal: true

module Crud
  module Reservation
    module Operations
      class Create < Trailblazer::Operation
        step Model(User, :new)
        step Contract::Build()
        step Contract::Validate()
        step Contract::Persist()
      end
    end
  end
end
