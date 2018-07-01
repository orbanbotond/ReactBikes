# frozen_string_literal: true

module Bikes
  class Ping < Grape::API
    format :json
    prefix :api

    desc "Returns pong."
    params do
      optional :pong, type: String, description: "A simple string which will be returned as it is."
    end
    get :ping do
      { ping: params[:pong] || "pong" }
    end
  end
end
