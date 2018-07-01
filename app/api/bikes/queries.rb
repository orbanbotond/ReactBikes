# frozen_string_literal: true

module Bikes
  class Queries < Grape::API
    helpers ::Helpers::AuthenticationHelper
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
        result = ::Queries::Operations::AvailableBikes.call(params, default_additional_params)
        if result.failure?
          format_errors(result)
        else
          present result["model"], with: ::Entities::BikeEntity
        end
      end
    end
  end
end
