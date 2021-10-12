# frozen_string_literal: true

module Bikes
  class Bikes < Grape::API
    helpers ::Helpers::ApiAuthenticationHelper
    helpers ::Helpers::OperationAdapter
    before { authenticate! }

    format :json
    prefix :api

    namespace :bikes do
      desc "Creates a bike." do
        detail "Returns a bikes"
        success ::Entities::BikeEntity
        failure [[401, "Unauthenticated"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      post do
        call_action(::Crud::Bike::Create, params, default_additional_params) do |result|
          present result, with: ::Entities::BikeEntity
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
          call_action(::Crud::Common::Read, params.merge(ar_class: :bike), default_additional_params) do |model|
            present model.reservations, with: ::Entities::ReservationEntity
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
          call_action(::Crud::Common::Read, params.merge(ar_class: :bike), default_additional_params) do |model|
            present model, with: ::Entities::BikeEntity
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
          call_action(::Crud::Common::Delete, params.merge(ar_class: :bike), default_additional_params) do |model|
            present model, with: ::Entities::BikeEntity
          end
        end

        desc "Updates a bike." do
          detail "Returns a bikes"
          success ::Entities::BikeEntity
          failure [[401, "Unauthenticated"],
                   [404, "Not found"],
                   [400, "Bad Request"]]
          headers 'X-Auth-Token': {
                    description: "The authentication token",
                    required: true
                  }
        end
        put do
          call_action(::Crud::Bike::Update, params, default_additional_params) do |result|
            present result, with: ::Entities::BikeEntity
          end
        end
      end
    end
  end
end
