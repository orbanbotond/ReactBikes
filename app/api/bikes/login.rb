# frozen_string_literal: true

module Bikes
  class Login < Grape::API
    helpers ::Helpers::ReturnFormatters

    format :json
    prefix :api

    desc "Login." do
      detail "The session token is returned"
      params  ::Login::Contracts::Default.documentation
      success ::Entities::Login::UserEntity
      failure [[400, "Bad Parameters"],
               [401, "Unauthenticated"]]
    end
    post :login do
      result = ::Login::Operations::Default.call(params, {})
      if result.failure?
        if result["contract.default"].errors[:password].present?
          code, message = ErrorCodes::INVALID_USER_PWD, "Email / Password do not match"
          details = result["contract.default"].errors.as_json["errors"]
          http_return_code = 401

          return error!(error_custom(code, message, details).as_json, http_return_code)
        else
          format_errors(result)
        end
      else
        present result["model"], with: ::Entities::Login::UserEntity
      end
    end
  end
end
