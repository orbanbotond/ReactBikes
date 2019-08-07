# frozen_string_literal: true

module Api
  module Queries
    class QueriesController < Api::BaseController
      before_action :authenticate!

      def available_bikes
        parsed_params = params.merge(
          "start_date" => parse_date( params[:start_date]),
          "end_date" => parse_date( params[:end_date]),
        )

        call_operation(::Queries::Operations::AvailableBikes, parsed_params, default_additional_params) do |result|
          render json: result[:model].map{|m|::Entities::BikeEntity.new(m).as_json}.as_json
        end
      end

      private

      def parse_date(date)
        ::Chronic.parse(date).to_datetime
      rescue
        ""
      end
    end
  end
end
