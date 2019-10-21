module Graphql
  module Lib
    module Service
      class EnsureHash
        def self.call(ambiguous_param)
          case ambiguous_param
          when String
            ambiguous_param.present? ? call(JSON.parse(ambiguous_param)) : {}
          when Hash, ActionController::Parameters
            ambiguous_param
          when nil
            {}
          else
            raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
          end
        end
      end
    end
  end
end
