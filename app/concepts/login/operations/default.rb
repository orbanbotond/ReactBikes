# frozen_string_literal: true

module Login
  module Operations
    class Default < Trailblazer::Operation
      step Contract::Build(constant: ::Login::Contracts::Default)
      step Contract::Validate()
    end
  end
end
