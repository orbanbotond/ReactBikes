# frozen_string_literal: true

module Helpers
  module ApiAuthenticationHelper
    include AuthenticationHelper
    include ReturnFormatters

    TOKEN_PARAM_NAME = "X-Auth-Token"

    def session_token(token_param = TOKEN_PARAM_NAME)
      @session_token ||= headers[token_param]
    end

    def authenticate!
      error!(error_from_system(ErrorCodes::SESSION_TOKEN_INVALID, "Session-Token is invalid"), 401) unless signed_in?
    end
  end
end
