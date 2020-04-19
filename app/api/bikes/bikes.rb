# frozen_string_literal: true

module Bikes
  class Bikes < Grape::API
    helpers ::Helpers::AuthenticationHelper
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
        model = Crud::Bike::Create.as(:system).new(params).perform
        present model, with: ::Entities::BikeEntity
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
          model = Crud::Common::Read.as(:system).new(params.merge(ar_class: :bike)).perform
          present model.reservations, with: ::Entities::ReservationEntity
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
          model = Crud::Common::Read.as(:system).new(params.merge(ar_class: :bike)).perform
          present model, with: ::Entities::BikeEntity
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
          model = Crud::Common::Delete.as(:system).new(params.merge(ar_class: :bike)).perform
          present model, with: ::Entities::BikeEntity
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
          model = Crud::Bike::Update.as(:system).new(params).perform
          present model, with: ::Entities::BikeEntity
        end
      end
    end
  end
end
