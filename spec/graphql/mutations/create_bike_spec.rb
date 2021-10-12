# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CreateBike" do
  let(:bike_model) { create :bike_model }

  subject(:scoped_reservations) do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]["createBike"]
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
            model{
              id
            }
            latitude,
            longitude
          },
          errors,
        } 
      }
    GQL
  end

  context "negative cases" do
    let(:current_user) { create :user }

    it "returns an error" do
      expect(subject["errors"]).to be_present
      expect(subject["bike"]).not_to be_present
    end
  end

  context "positive cases" do
    let(:current_user) { create :user, :admin }

    it "returns bike" do
      expect(subject["errors"]).not_to be_present
      expect(subject["bike"]).to be_present
    end
  end
end
