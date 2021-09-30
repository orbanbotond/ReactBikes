module Types
  class BikeModelType < Types::Base::Object
    description "A bike model"

    field :id, ID, null: false
    field :text, BikeModelsEnum, null: true,
          description: "The model of the bike"
  end
end
