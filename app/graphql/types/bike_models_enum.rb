module Types
  class BikeModelsEnum < ::Types::Base::Enum
    ::BikeModel.pluck(:text).each { |model| value model.camelize }
  end
end