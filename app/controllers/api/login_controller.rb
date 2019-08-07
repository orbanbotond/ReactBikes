# frozen_string_literal: true

module Api
  class LoginController < Api::BaseController
    include Api::ReturnFormatters

    def create
      result = ::Login::Operations::Default.call(params: params)
      if result.failure?
        if result["contract.default"].errors[:password].present?
          code, message = ErrorCodes::INVALID_USER_PWD, "Email / Password do not match"
          details = result["contract.default"].errors.as_json["errors"]
          http_return_code = 401

          render json: error_custom(code, message, details), status: http_return_code
        else
          render format_errors(result)
        end
      else
        render json: ::Entities::Login::UserEntity.new(result[:model]).as_json, status: :created
      end
    end
  end
end
