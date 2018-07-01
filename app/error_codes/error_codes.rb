# frozen_string_literal: true

module ErrorCodes
  # -- DB related codes -------------------------------
  RECORD_NOT_FOUND = 10

  # -- Input related codes -------------------------------
  INVALID_INPUT = 1000

  # -- Authentication Error -------------------------------
  INVALID_USER_PWD = 1010
  SESSION_TOKEN_INVALID = 1012

  # -- Process related codes -------------------------------
  ACCESS_DENIED = 2000

  # -- Other -------------------------------
  UNFORESEEN_SERVER_SIDE_ERROR = 100000
end
