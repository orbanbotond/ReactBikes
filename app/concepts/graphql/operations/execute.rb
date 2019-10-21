module Graphql
  module Operations
    class Execute < Trailblazer::Operation
      pass :variables!
      pass :query!
      pass :operation_name!
      pass :context!
      pass :model!

      def variables!(ctx, params:, **)
        ctx[:variables] = Graphql::Lib::Service::EnsureHash.call(params[:variables])
      end

      def query!(ctx, params:, **)
        ctx[:query] = params[:query]
      end

      def operation_name!(ctx, params:, **)
        ctx[:operation_name] = params[:operation_name]
      end

      def context!(ctx, **)
        ctx[:context] = {}
      end

      def model!(ctx, variables:, query:, context:, **)
        ctx[:model] = ToptalReactBikesSchema.execute
          query,
          variables: variables,
          context: context,
          operation_name: ctx[:operation_name]
      end
    end
  end
end
