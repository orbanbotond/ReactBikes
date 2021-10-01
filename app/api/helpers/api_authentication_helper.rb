# frozen_string_literal: true

module Helpers
  module ApiAuthenticationHelper
    include AuthenticationHelper
    include ReturnFormatters

    def authenticate!
      error!(error_from_system(ErrorCodes::SESSION_TOKEN_INVALID, "Session-Token is invalid"), 401) unless signed_in?
    end
  end
end
