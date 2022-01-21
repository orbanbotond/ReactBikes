# frozen_string_literal: true

module Helpers
  module OperationAdapter
    def call_action(action, params, additional_params = {})
      instantiated = action.as(additional_params[:current_user]).new(params.merge(additional_params))
      if instantiated.valid?
        yield instantiated.perform
      else
        format_action_errors(instantiated.errors)
      end
    end

    def call_operation(operation, params, additional_params)
      new_params = { params: params }.merge(additional_params)
      result = operation.call new_params
      if result.failure?
        format_errors(result)
      else
        yield result
      end
    end
  end
end
