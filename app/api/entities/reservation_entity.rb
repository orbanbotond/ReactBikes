# frozen_string_literal: true

module Entities
  class ReservationEntity < Grape::Entity
    expose :id
    expose :start_date
    expose :end_date
    expose :cancelled
    expose :rating
    expose :bike_id
    expose :user_id
  end
end
