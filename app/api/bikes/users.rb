# frozen_string_literal: true

module Bikes
  class Users < Grape::API
    helpers ::Helpers::AuthenticationHelper
    before { authenticate! }

    format :json
    prefix :api

    namespace :users do
      desc "Creates a user." do
        detail "Returns a user"
        success ::Entities::UserEntity
        params  ::Crud::User::Contracts::Create.documentation
        failure [[401, "Unauthenticated"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      post do
        result = ::Crud::Common::Operations::Create.call(params,
          "model.class" => ::User,
          "contract.default.class" => ::Crud::User::Contracts::Create
        )
        if result.failure?
          format_errors(result)
        else
          present result["model"], with: ::Entities::UserEntity
        end
      end

      desc "Users." do
        detail "Returns the users"
        success ::Entities::UserEntity
        failure [[401, "Unauthenticated"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      get do
        present User.all, with: ::Entities::UserEntity
      end

      route_param :id do
        desc "Reservation for a User." do
          detail "Returns the reservations of a user."
          success ::Entities::ReservationEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        get :reservations do
          result = ::Crud::Common::Operations::Read.call(params, "model.class" => ::User)
          if result.failure?
            format_errors(result)
          else
            present result["model"].reservations, with: ::Entities::ReservationEntity
          end
        end

        desc "User." do
          detail "Returns the users"
          success ::Entities::UserEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        get do
          result = ::Crud::Common::Operations::Read.call(params, "model.class" => ::User)
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::UserEntity
          end
        end

        desc "Deletes the user." do
          detail "Returns the delete user"
          success ::Entities::UserEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        delete do
          result = ::Crud::Common::Operations::Delete.call(params, "model.class" => ::User)
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::UserEntity
          end
        end

        desc "Updates the user." do
          detail "Returns the user"
          success ::Entities::UserEntity
          params  ::Crud::User::Contracts::Update.documentation
          failure [[401, "Unauthenticated"],
                   [404, "Not found"],
                   [400, "Bad Request"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        put do
          result = ::Crud::Common::Operations::Create.call(params,
            "model.class" => ::User,
            "contract.default.class" => ::Crud::User::Contracts::Update
          )
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::UserEntity
          end
        end
      end
    end
  end
end
