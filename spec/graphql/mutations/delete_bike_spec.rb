# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DeleteBike" do
  let!(:bike) { create :bike }
  let(:bike_id) { ToptalReactBikesSchema.id_from_object(bike, bike.class, {}) }

  subject do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]["deleteBike"]
  end

  let(:variables) do
    {
      "bikeId": bike_id
    }
  end

  let(:query_string) do
    <<~GQL
      mutation DeleteBike($bikeId: ID!){
        deleteBike(input: {bikeId: $bikeId}){
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
      end
    end
  end

  context "positive cases" do
    context "when authenticated" do
      let(:current_user) { create :user, :admin }

      it "returns no error" do
        expect(subject["errors"]).not_to be_present
      end

      it "removed a bike" do
        expect { subject }.to change { Bike.count }.by(-1)
      end
    end
  end
end
