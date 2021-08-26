module Types
  class BikeModelType < Types::BaseObject
    description "A bike model"

    field :id, ID, null: false
    field :text, String, null: true,
          description: "The model of the bike"
  end
end
