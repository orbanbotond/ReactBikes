# frozen_string_literal: true

module Bikes
  class Reservations < Grape::API
    helpers ::Helpers::AuthenticationHelper
    helpers ::Helpers::OperationAdapter
    before { authenticate! }

    format :json
    prefix :api

    namespace :reservations do
      desc "Creates a reservation." do
        detail "Returns a reservation"
        success ::Entities::ReservationEntity
        failure [[401, "Unauthenticated"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      post do
        params2 = params.merge(
          "start_at" => ::Chronic.parse(params[:start_date]).to_datetime,
          "end_at" => ::Chronic.parse(params[:end_date]).to_datetime,
        )
        call_action(::Crud::Reservation::Create, params2, default_additional_params) do |result|
          present result, with: ::Entities::ReservationEntity
        end
      end

      route_param :id do
        desc "Updates the reservation." do
          detail "Returns the reservation"
          success ::Entities::ReservationEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"],
                   [400, "Bad Request"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        put do
          call_action(::Crud::Reservation::Update, params) do |result|
            present result, with: ::Entities::ReservationEntity
          end
        end
      end
    end
  end
end
