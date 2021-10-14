# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UpdateBike" do
  let(:bike) { create :bike }
  let(:bike_id) { ToptalReactBikesSchema.id_from_object(bike, bike.class, {}) }

  subject do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]["updateBike"]
  end

  let(:variables) do
    {
      "bikeId": bike_id,
      "weight": 11
    }
  end

  let(:query_string) do
    <<~GQL
      mutation UpdateBikes($color: BikeColorsEnum, $weight: Float, $latitude: Float, $longitude: Float, $bikeModelId: ID, $bikeId: ID!){
        updateBike(input: {color: $color,#{' '}
                           weight: $weight,
                           bikeModelId: $bikeModelId
                           latitude: $latitude,
                           longitude: $longitude,
                           bikeId: $bikeId}){
          bike {
            id,
          },
          errors,
        }
      }
    GQL
  end

  context "negative cases" do
    context "when not authenticated" do
      let(:current_user) { create :user }

      it "returns an error" do
        expect(subject["errors"]).to be_present
        expect(subject["bike"]).not_to be_present
      end
    end
  end

  context "positive cases" do
    context "when authenticated" do
      let(:current_user) { create :user, :admin }

      it "returns bike" do
        expect(subject["errors"]).not_to be_present
        expect(subject["bike"]).to be_present
      end
    end
  end
end
