# frozen_string_literal: true

require "rails_helper"

RSpec.describe "BikeReservationType" do
  context "when asked for the reservation of the bikes" do
    subject(:scoped_reservations) do
      context = { current_user: current_user }
      result = ToptalReactBikesSchema.execute(query_string, context: context, variables: {})
      result.to_h["data"]["bikes"]["nodes"].first["reservations"].map { |r|r["id"] }
    end
    let(:query_string) do
      <<~GQL
        {
          bikes(id:"#{bike_id}"){
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
    let!(:bike) { create :bike }
    let(:bike_id) { ToptalReactBikesSchema.id_from_object(bike, bike.class, {}) }
    let!(:reservation_for_bike) { create :reservation, bike: bike }
    let!(:reservation_for_bike_id) { ToptalReactBikesSchema.id_from_object(reservation_for_bike, reservation_for_bike.class, {}) }
    let!(:bike_2) { create :bike }
    let!(:reservation_for_bike_2) { create :reservation, bike: bike_2 }
    let!(:reservation_for_bike_2_id) { ToptalReactBikesSchema.id_from_object(reservation_for_bike_2, reservation_for_bike_2.class, {}) }
    let(:parent_scope) { bike.reservations }

    context "when the user is admin" do
      let(:current_user) { create :user, admin: true }

      it "returns all the reservations belonging to that bike" do
        expect(scoped_reservations).to include(reservation_for_bike_id)
      end
      it "does not return the reservations belonging to other bike" do
        expect(scoped_reservations).to_not include(reservation_for_bike_2_id)
      end
    end

    context "when the user is a regular user" do
      let(:current_user) { create :user }

      it "he won't see any reservations" do
        expect(scoped_reservations).to be_empty
      end
    end
  end

  context "when asked for the reservation of the user" do
    subject(:scoped_reservations) do
      context = { current_user: current_user }
      result = ToptalReactBikesSchema.execute(query_string, context: context, variables: {})
      result.to_h["data"]["users"]["nodes"].first["reservations"].map { |r|r["id"] }
    end
    let(:query_string) do
      <<~GQL
        {
          users(id:"#{target_user_id}"){
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

    let!(:target_user) { create :user }
    let(:target_user_id) { ToptalReactBikesSchema.id_from_object(target_user, target_user.class, {}) }
    let!(:reservation_for_target_user) { create :reservation, user: target_user }
    let(:reservation_for_target_user_id) { ToptalReactBikesSchema.id_from_object(reservation_for_target_user, reservation_for_target_user.class, {}) }
    let!(:other_target_user) { create :user }
    let!(:reservation_for_other_target_user) { create :reservation, user: other_target_user }
    let(:reservation_for_other_target_user_id) { ToptalReactBikesSchema.id_from_object(reservation_for_other_target_user, reservation_for_other_target_user.class, {}) }

    context "when the user is admin" do
      let(:current_user) { create :user, admin: true }

      it "returns all the reservations belonging to that user" do
        expect(scoped_reservations).to include(reservation_for_target_user_id)
      end

      it "does not returns the reservations belonging to other target user" do
        expect(scoped_reservations).to_not include(reservation_for_other_target_user_id)
      end
    end

    context "when the user is a regular user" do
      let(:current_user) { create :user }

      context "when he asks for its own reservations" do
        let(:target_user) { current_user }
        let(:reservation_for_current_user) { reservation_for_target_user }
        let(:reservation_for_current_user_id) { ToptalReactBikesSchema.id_from_object(reservation_for_current_user, reservation_for_current_user.class, {}) }

        it "returns its own reservations" do
          expect(scoped_reservations).to include(reservation_for_current_user_id)
        end
        it "does not returns the reservations belonging to other target user" do
          expect(scoped_reservations).to_not include(reservation_for_other_target_user_id)
        end
      end

      context "when he asks for other users reservations" do
        it "he won't see any reservations" do
          expect(scoped_reservations).to be_empty
        end
      end
    end
  end
end
