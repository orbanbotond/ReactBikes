# frozen_string_literal: true

module Signup
  module Operations
    class Default < Trailblazer::Operation
      step Model(User, :new)
      step Contract::Build(constant: ::Signup::Contracts::Default)
      step Contract::Validate()
      step Contract::Persist()
      step :store_hashed_pwd

      def store_hashed_pwd(options, model:, params:, **)
        model.hashed_password = User.pwd_hash params[:password]
        model.save
      end
    end
  end
end
