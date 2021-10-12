# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CreateBike" do
  let(:bike_model) { create :bike_model }

  subject(:scoped_reservations) do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]
  end

  let(:variables) do
    {
      "color": "red",
      "weight": 3.5,
      "bikeModelId": bike_model.id,
      "latitude": 23.15,
      "longitude": 35.38
    }
  end

  let(:query_string) do
    <<~GQL
      mutation createBikes($color: BikeColorsEnum!, $weight: Float!, $latitude: Float!, $longitude: Float!, $bikeModelId: Int!){
        createBike(input: {color: $color, 
                           weight: $weight,
                           latitude: $latitude,
                           longitude: $longitude,
                           bikeModelId: $bikeModelId}){
          bike {
            id,
            color,
            weight,
            bikeModelId,
            latitude,
            longitude
          },
          errors,
        } 
      }
    GQL
  end

  context "negative cases" do
    let(current_user) { create :user }

    it{ is_expected.to_not include("createBike") }
    it{ is_expected.to include("errors") }
  end

  context "positive cases" do
    let(current_user) { create :user, :admin }

    it{ is_expected.to include("createBike") }
    it{ is_expected.to_not include("errors") }
  end
end
