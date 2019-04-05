# frozen_string_literal: true

module Helpers
  module OperationAdapter
    def call_operation(operation, params, additional_params)
      result = operation.call params, additional_params
      if result.failure?
        format_errors(result)
      else
        yield result
      end
    end
  end
end
