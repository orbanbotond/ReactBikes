# frozen_string_literal: true

module Resolvers
  module Users
    def users(id: nil)
      relation = if id.present?
        User.where(id: id)
      else
        User.all
      end
      relation
    end
  end
end
