# frozen_string_literal: true

module AuthenticationHelper
  def guest_call?
    !can_authenticate?
  end

  def can_authenticate?
    session_token
  end

  TOKEN_PARAM_NAME = "HTTP_X_AUTH_TOKEN"

  def session_token(token_param = TOKEN_PARAM_NAME)
    @session_token ||= request.headers[token_param]
  end

  def pundit_user
    current_user
  end

  def default_additional_params
    { "current_user" => current_user }.with_indifferent_access
  end

  def current_user
    return nil unless can_authenticate?

    user = user_from_session_token

    @current_user ||= user
  end

  def signed_in?
    !!current_user
  end

private
  def user_from_session_token
    User.find_by(hashed_session_token: User.pwd_hash(session_token))
  end
end
