# frozen_string_literal: true

module Bikes
  class API < Grape::API
    rescue_from :all do |e|
      binding.pry if Rails.env.development?
      # binding.pry if Rails.env.test?

      code, message = ErrorCodes::UNFORESEEN_SERVER_SIDE_ERROR, "Unforeseen Server Side Error Occured"
      http_return_code = 500

      rack_response(error_from_system(code, message).to_json, http_return_code)
    end

    mount Bikes::Ping
    mount Bikes::Login
    mount Bikes::Signup
    mount Bikes::Models
    mount Bikes::Bikes

    add_swagger_documentation
  end
end
