# frozen_string_literal: true

module Entities
  class BikeEntity < Grape::Entity
    include ActionDispatch::Routing::PolymorphicRoutes

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
    expose :image_url do |model|
      if model.picture.attachment.present?
        Rails.application.routes.url_helpers.rails_blob_path(model.picture, only_path: true)
      else
        nil
      end
    end
  end
end
