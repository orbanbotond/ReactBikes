# frozen_string_literal: true

module Resolvers
  module Users
    def users(id: nil)
      if id.present?
        ToptalReactBikesSchema.object_from_id(id, context)
      else
        User.all
      end
    end
  end
end
