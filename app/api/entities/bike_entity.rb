# frozen_string_literal: true

module Entities
  class BikeEntity < Grape::Entity
    format_with(:rounded_decimal) do |field|
      field.round(10).to_f
    end

    with_options(format_with: :rounded_decimal) do
	    expose :average_rating
	    expose :latitude
	    expose :longitude
    end

    expose :id
    expose :weight
    expose :color
    expose :bike_model_id
  end
end
