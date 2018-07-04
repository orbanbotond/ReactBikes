# frozen_string_literal: true

module Bikes
  class Queries < Grape::API
    helpers ::Helpers::AuthenticationHelper
    helpers ::Helpers::OperationAdapter
    before { authenticate! }

    format :json
    prefix :api

    namespace :queries do
      desc "Returns the available bikes." do
        detail "Returns the available bikes"
        success ::Entities::BikeEntity
        params  ::Queries::Contracts::AvailableBikes.documentation
        failure [[401, "Unauthenticated"],
                 [404, "Not found"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      get :available_bikes do
        call_operation(::Queries::Operations::AvailableBikes, params, default_additional_params) do |result|
          present result["model"], with: ::Entities::BikeEntity
        end
      end
    end
  end
end
