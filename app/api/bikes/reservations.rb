# frozen_string_literal: true

module Bikes
  class Reservations < Grape::API
    helpers ::Helpers::AuthenticationHelper
    before { authenticate! }

    format :json
    prefix :api

    namespace :reservations do
      desc "Creates a reservation." do
        detail "Returns a reservation"
        success ::Entities::ReservationEntity
        params  ::Crud::Reservation::Contracts::Create.documentation
        failure [[401, "Unauthenticated"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      post do
        additional_params = default_additional_params.merge(
          "contract.default.class" => ::Crud::Reservation::Contracts::Create
        )
        binding.pry
        params2 = params.merge({
          "start_at" => ::Chronic.parse(params[:start_date]).to_datetime,
          "end_at" => ::Chronic.parse(params[:end_date]).to_datetime,
        })
        result = ::Crud::Reservation::Operations::Create.call(params2, additional_params)
        if result.failure?
          format_errors(result)
        else
          present result["model"], with: ::Entities::ReservationEntity
        end
      end

      route_param :id do
        desc "Updates the reservation." do
          detail "Returns the reservation"
          success ::Entities::ReservationEntity
          params  ::Crud::Reservation::Contracts::Update.documentation
          failure [[401, "Unauthenticated"],
                   [404, "Not found"],
                   [400, "Bad Request"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        put do
          result = ::Crud::Reservation::Operations::Update.call(params, default_additional_params)
          if result.failure?
            format_errors(result)
          else
            present result["model"], with: ::Entities::ReservationEntity
          end
        end
      end
    end
  end
end
