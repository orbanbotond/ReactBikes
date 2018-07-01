# frozen_string_literal: true

module Bikes
  class Bikes < Grape::API
    helpers ::Helpers::AuthenticationHelper
    before { authenticate! }

    format :json
    prefix :api

    desc "Bikes." do
      detail "Returns the bikes"
      success ::Entities::BikeModelEntity
      failure [[401, "Unauthenticated"]]
      headers 'X-Auth-Token': {
                description: "The authentication token",
                required: true
              }
    end
    get :bikes do
      present Bike.all, with: ::Entities::BikeEntity
    end
  end
end
