# frozen_string_literal: true

require "rails_helper"

describe Queries::AvailableBikes, type: :model do
  subject(:action) { described_class.as(:system).new(params) }
  let(:params) { attributes_for(:reservation).slice(:start_date, :end_date) }

  context "validations" do
    context "start_date is in the past" do
      let(:params) { super().merge(start_date: 1.day.ago.to_datetime) }

      it { is_expected.not_to be_valid }
    end

    context "end_date is in the past" do
      let(:params) { super().merge(end_date: 1.day.ago.to_datetime) }

      it { is_expected.not_to be_valid }
    end

    context "end_date is before the start_date" do
      let(:params) { super().merge(end_date: 1.day.from_now.to_datetime) }

      it { is_expected.not_to be_valid }
    end

    context "field presence" do
      it { is_expected.to validate_presence_of(:start_date) }
      it { is_expected.to validate_presence_of(:end_date) }
    end

    context "rating" do
      it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
    end

    context "positive case" do
      context "other fields are specified" do
        let!(:model) { create :bike_model }
        let(:params) { super().merge(color: ::Bike::COLORS.first, bike_model_id: model.id, weight: 1.2, rating: 3) }

        it { is_expected.to be_valid }
      end
    end
  end

  context "functionality" do
    subject(:action) {
      described_class.as(:system).new(params).perform
    }

    let(:current_user) { create :user, :admin }

    let(:start_date) { 2.days.from_now.to_datetime }
    let(:end_date) { 4.days.from_now.to_datetime }
    let!(:reservation_n_01) do
      create :reservation,
             start_date: 3.days.from_now.to_datetime,
             end_date: 5.days.from_now.to_datetime
    end
    let(:bike_n_01) { reservation_n_01.bike }
    let!(:reservation_n_02) do
      create :reservation,
             start_date: 1.days.from_now.to_datetime,
             end_date: 3.days.from_now.to_datetime
    end
    let(:bike_n_02) { reservation_n_02.bike }
    let!(:reservation_p_01) do
      create :reservation,
             start_date: 5.days.from_now.to_datetime,
             end_date: 6.days.from_now.to_datetime,
             bike: create(:bike, average_rating: 5)
    end
    let(:bike_p_01) { reservation_p_01.bike }
    let!(:reservation_p_02) do
      create :reservation,
             start_date: 2.days.ago.to_datetime,
             end_date: 1.days.ago.to_datetime,
             bike: create(:bike, color: Bike::COLORS.first)
    end
    let(:bike_p_02) { reservation_p_02.bike }
    let!(:bike_p_03) { create :bike, weight: 1.0 }
    let(:params) { { start_date: start_date, end_date: end_date } }

    context "default search" do
      it "returns just the available bikes" do
        expect(action).to_not include(bike_n_01)
        expect(action).to_not include(bike_n_02)
        expect(action).to include(bike_p_01)
        expect(action).to include(bike_p_02)
        expect(action).to include(bike_p_03)
      end
    end

    context "refined search color" do
      let(:params) { super().merge(color: ::Bike::COLORS.first) }

      it "returns just the available bikes" do
        expect(action).to_not include(bike_n_01)
        expect(action).to_not include(bike_n_02)
        expect(action).to_not include(bike_p_01)
        expect(action).to_not include(bike_p_03)

        expect(action).to include(bike_p_02)
      end
    end
    context "refined search weight" do
      let(:params) { super().merge(weight: 1.2) }

      it "returns just the available bikes" do
        expect(action).to_not include(bike_n_01)
        expect(action).to_not include(bike_n_02)
        expect(action).to_not include(bike_p_01)
        expect(action).to_not include(bike_p_02)

        expect(action).to include(bike_p_03)
      end
    end

    context "refined search rating" do
      let(:params) { super().merge(rating: 5) }

      it "returns just the available bikes" do
        expect(action).to_not include(bike_n_01)
        expect(action).to_not include(bike_n_02)
        expect(action).to_not include(bike_p_02)
        expect(action).to_not include(bike_p_03)

        expect(action).to include(bike_p_01)
      end
    end

    context "refined search model" do
      let(:params) { super().merge(bike_model_id: bike_p_01.bike_model.id) }

      it "returns just the available bikes" do
        expect(action).to_not include(bike_n_01)
        expect(action).to_not include(bike_n_02)
        expect(action).to_not include(bike_p_02)
        expect(action).to_not include(bike_p_03)

        expect(action).to include(bike_p_01)
      end
    end
  end
end
