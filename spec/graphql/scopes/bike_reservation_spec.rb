# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BikeReservationType" do
  let(:query_string) do
    <<~GQL
      {
        bikes(id:"#{bike.id}"){
          nodes {
            id,
            reservations {
              id,
            }
          }
        }
      }
    GQL
  end

  subject(:scoped_reservations) do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: {})
    result.to_h["data"]["bikes"]["nodes"].first["reservations"].map{|r|r["id"].to_i}
  end

  context "when the users asks for the reservation of the bikes" do
    let!(:bike) { create :bike}
    let!(:reservation_for_bike) { create :reservation, bike: bike }
    let!(:bike_2) { create :bike }
    let!(:reservation_for_bike_2) { create :reservation, bike: bike_2 }
    let(:parent_scope) { bike.reservations }

    context "when the user is admin" do
      let(:current_user) { create :user, admin: true }

      it "returns all the reservations belonging to that bike" do
        expect(scoped_reservations).to include(reservation_for_bike.id)
      end
      it "does not return the reservations belonging to other bike" do
        expect(scoped_reservations).to_not include(reservation_for_bike_2.id)
      end
    end

    context "when the user is a regular user" do
      let(:current_user) { create :user }

      it "he won't see any reservations" do
        expect(scoped_reservations).to be_empty
      end
    end
  end
end
