# frozen_string_literal: true

module Entities
  module Login
    class UserEntity < Grape::Entity
      expose :id
      expose :email
      expose :admin
      expose :session_token
      expose :gql_id do |model|
        ToptalReactBikesSchema.id_from_object(model, model.class, {})
      end
    end
  end
end
