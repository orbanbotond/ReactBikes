# frozen_string_literal: true

module Resolvers
  module Bikes
    def bikes(id: nil)
      if id.present?
        ToptalReactBikesSchema.object_from_id(id, context)
      else
        Bike.all
      end
    end
  end
end
