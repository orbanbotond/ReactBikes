# frozen_string_literal: true

module ApiHelpers
  module ReturnFormatters
    def format_errors(result)
      if (key = result["result.policy.default"]) && key.failure?
        code, message = ErrorCodes::ACCESS_DENIED, "Access Denied"
        http_return_code = 403
      elsif (key = result["result.model"]) && key.failure?
        code, message = ErrorCodes::RECORD_NOT_FOUND, "Record Not Found."
        http_return_code = 404
      elsif result["result.contract.default"] && result["result.contract.default"].failure?
        code, message = ErrorCodes::INVALID_INPUT, "Bad Parameters"
        details = result["contract.default"].errors.as_json["errors"]
        http_return_code = 400
      end

      if details
        error!(error_custom(code, message, details).as_json, http_return_code)
      else
        error!(error_from_system(code, message).as_json, http_return_code)
      end
    end

    def error_custom(code, message, details)
      { error_code: code,
        error_message: message,
        details: details.as_json
      }
    end

    # def error_from_form(code, message, details)
    #   { error_code: code,
    #     error_message: message,
    #     details: details.as_json["errors"]
    #   }
    # end

    def error_from_system(code, msg)
      {
        error_code: code,
        error_message: msg
      }
    end
  end
end