# frozen_string_literal: true

module Entities
  class BikeModelEntity < Grape::Entity
    expose :id
    expose :text
  end
end
