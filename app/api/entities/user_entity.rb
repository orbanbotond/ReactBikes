# frozen_string_literal: true

module Entities
  class UserEntity < Grape::Entity
    expose :email
    expose :session_token
  end
end
