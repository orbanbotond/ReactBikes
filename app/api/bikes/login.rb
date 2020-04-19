# frozen_string_literal: true

module Bikes
  class Login < Grape::API
    helpers ::Helpers::ReturnFormatters

    format :json
    prefix :api

    desc "Login." do
      detail "The session token is returned"
      success ::Entities::Login::UserEntity
      failure [[400, "Bad Parameters"],
               [401, "Unauthenticated"]]
    end
    post :login do
      action = ::Login::Action.as(:system).new(params)
      if action.valid?
        present action.perform, with: ::Entities::Login::UserEntity
      else
        code, message = ErrorCodes::INVALID_USER_PWD, "Email / Password do not match"
        details = action.errors.as_json
        http_return_code = 401

        return error!(error_custom(code, message, details).as_json, http_return_code)
      end
    end
  end
end
