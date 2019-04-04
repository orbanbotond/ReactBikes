# frozen_string_literal: true

module Login
  module Operations
    class Default < Trailblazer::Operation
      step Contract::Build(constant: ::Login::Contracts::Default)
      step Contract::Validate()
      step :populate_model
      step :store_hashed_session_token

      def populate_model(options, params:, **)
        options[:model] = User.find_by(email: params[:email])
      end

      def store_hashed_session_token(options, model:, **)
        model.hashed_session_token = User.pwd_hash(model.session_token)
        model.save
      end
    end
  end
end
