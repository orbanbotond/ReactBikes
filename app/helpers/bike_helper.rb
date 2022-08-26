# frozen_string_literal: true

module BikeHelper
  def image(bike)
    if(bike.picture.attachment.present?)
      url = Rails.application.routes.url_helpers.rails_blob_path(model.picture, only_path: true)
      image_tag src: url, width: 50
    end
  end
end
