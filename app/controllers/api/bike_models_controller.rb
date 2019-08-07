# frozen_string_literal: true

module Api
  class BikeModelsController < Api::BaseController
    before_action :authenticate!

    def index
      render json: BikeModel.all.map{|model| ::Entities::BikeModelEntity.new(model).as_json}.as_json
    end
  end
end
