# frozen_string_literal: true

module Entities
  class UserEntity < Grape::Entity
    expose :email
    expose :password
    expose :session_token do |model|
      Digest::MD5.hexdigest model.password
    end
  end
end
