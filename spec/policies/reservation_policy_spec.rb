# frozen_string_literal: true

require "rails_helper"

RSpec.describe ReservationPolicy, type: :model do
  subject(:actual_scope) { ReservationPolicy::Scope.new(current_user, parent_scope).resolve }

  describe "scopes" do
    context "when the users asks for the reservation of the bikes" do
      let!(:bike) { create :bike }
      let!(:reservation_for_bike) { create :reservation, bike: bike }
      let!(:bike_2) { create :bike }
      let!(:reservation_for_bike_2) { create :reservation, bike: bike_2 }
      let(:parent_scope) { bike.reservations }

      context "when the user is admin" do
        let(:current_user) { create :user, admin: true }

        it "returns all the reservations belonging to that bike" do
          expect(actual_scope).to include(reservation_for_bike)
        end

        it "does not return the reservations belonging to other bike" do
          expect(actual_scope).to_not include(reservation_for_bike_2)
        end
      end

      context "when the user is a regular user" do
        let(:current_user) { create :user }

        it "he won't see any reservations" do
          expect(actual_scope).to be_empty
        end
      end
    end

    context "when the users asks for the reservation of the user" do
      let!(:target_user) { create :user }
      let!(:reservation_for_target_user) { create :reservation, user: target_user }
      let!(:other_target_user) { create :user }
      let!(:reservation_for_other_target_user) { create :reservation, user: other_target_user }

      context "when the user is admin" do
        let(:parent_scope) { target_user.reservations }
        let(:current_user) { create :user, admin: true }

        it "returns all the reservations belonging to that user" do
          expect(actual_scope).to include(reservation_for_target_user)
        end

        it "does not returns the reservations belonging to other target user" do
          expect(actual_scope).to_not include(reservation_for_other_target_user)
        end
      end

      context "when the user is a regular user" do
        let(:current_user) { target_user }
        let(:parent_scope) { current_user.reservations }
        let(:reservation_for_current_user) { reservation_for_target_user }

        context "when he asks for its own reservations" do
          it "returns its own reservations" do
            expect(actual_scope).to include(reservation_for_current_user)
          end

          it "does not returns the reservations belonging to other target user" do
            expect(actual_scope).to_not include(reservation_for_other_target_user)
          end
        end

        context "when he asks for other users reservations" do
          let(:parent_scope) { other_target_user.reservations }

          it "he won't see any reservations" do
            expect(actual_scope).to be_empty
          end
        end
      end
    end
  end

  describe "allowances" do
    context "when updating" do
      let(:reservation) { create :reservation }
      subject(:policy) { ReservationPolicy.new(current_user, reservation) }

      describe "negative cases" do
        context "when user doesn't own the reservation" do
          let(:current_user) { create :user }

          it { is_expected.to_not permit_action(:update) }
        end
      end

      describe "positive cases" do
        context "when user owns the reservation" do
          let(:current_user) { reservation.user }

          it { is_expected.to permit_action(:update) }
        end

        context "when user is admin" do
          let(:current_user) { create :user, :admin }

          it { is_expected.to permit_action(:update) }
        end
      end
    end
  end
end
