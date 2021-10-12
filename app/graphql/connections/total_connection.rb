# frozen_string_literal: true

module Connections
  class TotalConnection < Types::Base::Connection
    field :total_count, Integer, null: false

    def total_count
      object.items.count
    end
  end
end
