# frozen_string_literal: true

module Entities
  class ReservationEntity < Grape::Entity
    expose :id
    expose :start_at
    expose :end_at
    expose :cancelled
    expose :rating
  end
end
