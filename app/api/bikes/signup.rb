# frozen_string_literal: true

module Bikes
  class Signup < Grape::API
    helpers ::Helpers::ReturnFormatters

    format :json
    prefix :api

    desc "Signup." do
      detail "The user signs up"
      params  ::Signup::Contracts::Default.documentation
      success ::Entities::UserEntity
      failure [[400, "Bad Parameters"]]
    end
    post :signup do
      result = ::Signup::Operations::Default.call(params, {})
      if result.failure?
        format_errors(result)
      else
        present result["model"], with: ::Entities::UserEntity
      end
    end
  end
end
