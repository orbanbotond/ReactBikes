# frozen_string_literal: true

module Entities
  class UserEntity < Grape::Entity
    expose :id
    expose :email
    expose :admin
  end
end
