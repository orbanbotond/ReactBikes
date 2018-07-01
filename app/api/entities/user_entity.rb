# frozen_string_literal: true

module Entities
  class UserEntity < Grape::Entity
    expose :email
  end
end
