# frozen_string_literal: true

module Entities
  class ReservationEntity < Grape::Entity
    expose :id
    expose :start_date
    expose :end_date
    expose :cancelled
    expose :rating
  end
end
