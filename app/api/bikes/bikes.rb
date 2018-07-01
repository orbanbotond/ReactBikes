# frozen_string_literal: true

module Bikes
  class Bikes < Grape::API
    helpers ::Helpers::AuthenticationHelper
    before { authenticate! }

    format :json
    prefix :api

    namespace :bikes do
      desc "Creates a bike." do
        detail "Returns a bikes"
        success ::Entities::BikeEntity
        params  ::Crud::Bike::Contracts::Create.documentation
        failure [[401, "Unauthenticated"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      post do
        additional_params = default_additional_params.merge(
          "model.class" => ::Bike,
          "contract.default.class" => ::Crud::Bike::Contracts::Create
        )

        result = ::Crud::Common::Operations::Create.call(params, additional_params)
        if result.failure?
          format_errors(result)
        else
          present result["model"], with: ::Entities::BikeEntity
        end
      end

      desc "Bikes." do
        detail "Returns the bikes"
        success ::Entities::BikeEntity
        failure [[401, "Unauthenticated"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      get do
        present Bike.all, with: ::Entities::BikeEntity
      end

      route_param :id do
        desc "Reservation for a Bike." do
          detail "Returns the reservations for the bikes."
          success ::Entities::ReservationEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        get :reservations do
          additional_params = default_additional_params.merge(
            "model.class" => ::Bike
          )

          result = ::Crud::Common::Operations::Read.call(params, additional_params)
          if result.failure?
            format_errors(result)
          else
            present result["model"].reservations, with: ::Entities::ReservationEntity
          end
        end

        desc "Bike." do
          detail "Returns a bikes"
          success ::Entities::BikeEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        get do
          additional_params = default_additional_params.merge(
            "model.class" => ::Bike
          )

          result = ::Crud::Common::Operations::Read.call(params, additional_params)
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::BikeEntity
          end
        end

        desc "Deletes a bike." do
          detail "Returns a bikes"
          success ::Entities::BikeEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        delete do
          additional_params = default_additional_params.merge(
            "model.class" => ::Bike
          )

          result = ::Crud::Common::Operations::Delete.call(params, additional_params)
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::BikeEntity
          end
        end

        desc "Updates a bike." do
          detail "Returns a bikes"
          success ::Entities::BikeEntity
          params  ::Crud::Bike::Contracts::Update.documentation
          failure [[401, "Unauthenticated"],
                   [404, "Not found"],
                   [400, "Bad Request"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        put do
          additional_params = default_additional_params.merge(
            "model.class" => ::Bike,
            "contract.default.class" => ::Crud::Bike::Contracts::Update
          )

          result = ::Crud::Common::Operations::Update.call(params, additional_params)
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::BikeEntity
          end
        end
      end
    end
  end
end
