# frozen_string_literal: true

class GraphqlController < ApplicationController
  include AuthenticationHelper
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately

  skip_before_action :verify_authenticity_token

  def execute
    if signed_in?
      variables = prepare_variables(params[:variables])
      query = params[:query]
      operation_name = params[:operationName]
      context = {
        current_user: current_user,
      }
      result = ToptalReactBikesSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
      render json: result
    else
      render status: :unauthorized, json: { error: "You are not authorized to access this resource. Verify that you are passing passing your token." }
    end
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private
    # Handle variables in form data, JSON body, or a blank value
    def prepare_variables(variables_param)
      case variables_param
      when String
        if variables_param.present?
          JSON.parse(variables_param) || {}
        else
          {}
        end
      when Hash
        variables_param
      when ActionController::Parameters
        variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{variables_param}"
      end
    end

    def handle_error_in_development(e)
      logger.error e.message
      logger.error e.backtrace.join("\n")

      render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
    end
end
