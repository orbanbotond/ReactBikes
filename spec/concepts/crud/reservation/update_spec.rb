# frozen_string_literal: true

require "rails_helper"

describe Crud::Reservation::Update, type: :model do
  context "validations" do
    subject(:action) { described_class.as(:system).new(params) }

    let(:reservation) { create :reservation }
    let(:params) { { id: reservation.id, cancelled: true } }

    context "negative cases" do
      context "params are empty" do
        let(:params) { {} }

        it { is_expected.to_not be_valid }
      end

      context "both rating and cancelled are there" do
        let(:params) { { rating: 4, cancelled: true } }

        it { is_expected.to_not be_valid }
      end

      context "rating" do
        it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
      end
    end

    context "positive case" do
      context "cancelling" do
        it { is_expected.to be_valid }
      end

      context "rating is specified" do
        let(:params) { { id: reservation.id, rating: 3 } }

        it { is_expected.to be_valid }
      end
    end
  end

  context 'functionality' do
    context "reservation" do
      subject(:action) { described_class.as(:system).new(params).perform }

      let(:model) { create :reservation }
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

      context "cancells" do
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
  end
end
