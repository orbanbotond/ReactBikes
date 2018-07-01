# frozen_string_literal: true

module Entities
  class BikeEntity < Grape::Entity
    expose :id
    expose :weight
    expose :color
    expose :latitude
    expose :longitude
    expose :bike_model_id
    expose :average_rating
  end
end
