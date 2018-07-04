# frozen_string_literal: true

module Bikes
  class Signup < Grape::API
    helpers ::Helpers::ReturnFormatters
    helpers ::Helpers::OperationAdapter

    format :json
    prefix :api

    desc "Signup." do
      detail "The user signs up"
      params  ::Signup::Contracts::Default.documentation
      success ::Entities::UserEntity
      failure [[400, "Bad Parameters"]]
    end
    post :signup do
      call_operation(::Signup::Operations::Default, params, {}) do |result|
        present result["model"], with: ::Entities::UserEntity
      end
    end
  end
end
