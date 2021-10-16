# frozen_string_literal: true

require "rails_helper"

describe Crud::Reservation::Update, type: :model do
  let(:current_user) { create :user, :admin }

  describe "validations" do
    subject(:action) { described_class.as(current_user).new(params) }

    let(:reservation) { create :reservation }
    let(:params) { { id: reservation.id, cancelled: true } }

    describe "negative cases" do
      context "when params are empty" do
        let(:params) { {} }

        it { is_expected.to_not be_valid }
      end

      context "when both rating and cancelled are there" do
        let(:params) { { rating: 4, cancelled: true } }

        it { is_expected.to_not be_valid }
      end
    end

    context "positive case" do
      context "cancelling" do
        it { is_expected.to be_valid }
      end

      context "when rating is its range" do
        it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
      end
    end
  end

  describe "functionality" do
    subject(:action) { described_class.as(current_user).new(params).perform }
    let(:model) { create :reservation }

    context "when updating the rating" do
      let(:params) { { id: model.id, rating: 5 } }

      it "updates the old model" do
        params
        expect do
          expect do
            expect(action).to be_a(Reservation)
            expect(action.rating).to eq(params[:rating])
            expect(action.bike.average_rating).to eq(params[:rating])
          end.to_not change { Reservation.count }
        end.to change { model.bike.reload.average_rating }
      end
    end

    context "when cancelling the reservation" do
      let(:params) { { id: model.id, cancelled: true } }

      it "cancells" do
        params
        expect do
          expect(action).to be_a(Reservation)
          expect(action.cancelled).to eq(params[:cancelled])
        end.to_not change { Reservation.count }
      end
    end
  end

  describe "security" do
    subject(:action) { described_class.as(current_user).new(params).allowed? }
    let(:params) { { id: reservation.id, cancelled: true } }
    let(:reservation) { create :reservation }

    context "current_user owns the reservation" do
      let(:current_user) { reservation.user }

      it { is_expected.to be_truthy }
    end

    context "current_user is admin" do
      let(:current_user) { reservation.user }

      it { is_expected.to be_truthy }
    end

    context "current_user doesn't own the reservation" do
      let(:current_user) { create :user }

      it { is_expected.to be_falsy }
    end
  end
end
