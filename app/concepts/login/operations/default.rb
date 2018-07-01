# frozen_string_literal: true

module Login
  module Operations
    class Default < Trailblazer::Operation
      step Contract::Build(constant: ::Login::Contracts::Default)
      step Contract::Validate()
      step :populate_model

      def populate_model(options, params:, **)
        options["model"] = User.find_by(email: params[:email])
      end
    end
  end
end
