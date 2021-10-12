# frozen_string_literal: true

module Bikes
  class Queries < Grape::API
    helpers ::Helpers::ApiAuthenticationHelper
    helpers ::Helpers::OperationAdapter
    before { authenticate! }

    format :json
    prefix :api

    helpers do
      def parse_date(date)
        ::Chronic.parse(date).to_datetime
      rescue
        ""
      end
    end


    namespace :queries do
      desc "Returns the available bikes." do
        detail "Returns the available bikes"
        success ::Entities::BikeEntity
        failure [[401, "Unauthenticated"],
                 [404, "Not found"],
                 [400, "Bad Request"]]
        headers 'X-Auth-Token': {
                  description: "The authentication token",
                  required: true
                }
      end
      get :available_bikes do
        params2 = params.merge(
          "start_date" => parse_date(params[:start_date]),
          "end_date" => parse_date(params[:end_date]),
        )

        call_action(::Queries::AvailableBikes, params2, default_additional_params) do |result|
          present result, with: ::Entities::BikeEntity
        end
      end
    end
  end
end
