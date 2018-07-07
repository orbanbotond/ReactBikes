# frozen_string_literal: true

module Entities
  module Login
    class UserEntity < Grape::Entity
      expose :email
      expose :admin
      expose :session_token
    end
  end
end
