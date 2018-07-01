# frozen_string_literal: true

module Bikes
  class Models < Grape::API
    helpers ::Helpers::AuthenticationHelper
    before { authenticate! }

    format :json
    prefix :api

    desc "Models." do
      detail "Returnd the models"
      success ::Entities::BikeModelEntity
      failure [[401, "Unauthenticated"]]
    end
    get :bike_models do
      present BikeModel.all, with: ::Entities::BikeModelEntity
    end
  end
end
