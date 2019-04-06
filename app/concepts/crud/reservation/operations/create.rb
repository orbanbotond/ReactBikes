# frozen_string_literal: true

module Crud
  module Reservation
    module Operations
      class Create < Trailblazer::Operation
        step Model(::Reservation, :new)

        step :set_user

        step Nested( ::Crud::Common::Operations::Persist)

        def set_user(options, current_user:, model:, **)
          model.user = current_user
        end
      end
    end
  end
end
