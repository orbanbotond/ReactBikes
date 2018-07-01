# frozen_string_literal: true

module Signup
  module Operations
    class Default < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: ::Signup::Contracts::Default)
      step Contract::Validate()
      step Contract::Persist()
    end
  end
end
