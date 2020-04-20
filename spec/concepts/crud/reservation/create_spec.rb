# frozen_string_literal: true

require "rails_helper"

describe Crud::Reservation::Create, type: :model do
  context "validations" do
    context "negative cases" do
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
        it { is_expected.to validate_presence_of(:current_user) }
        it { is_expected.to validate_presence_of(:end_date) }
        it { is_expected.to validate_presence_of(:bike_id) }
      end
    end

    context "positive case" do
      subject(:action) { described_class.as(:system).new(params) }
      let!(:bike) { create :bike }
      let(:current_user) { create :user, :admin }
      let(:params) { attributes_for(:reservation).merge(current_user: current_user, bike_id: bike.id, start_date: Date.today + 1.day, end_date: Date.today + 2.days) }

      it { is_expected.to be_valid }
    end
  end

  context "functionality" do
    subject(:action) { described_class.as(:system).new(params).perform }
    let!(:bike) { create :bike }
    let(:current_user) { create :user, :admin }

    let(:params) { attributes_for(:reservation).merge(current_user: current_user, bike_id: bike.id, start_date: Date.today + 1.day, end_date: Date.today + 2.days) }

    it "creates a new reservation" do
      params
      expect do
        expect(action).to be_a(Reservation)
        expect(action.start_date).to eq(params[:start_date])
        expect(action.end_date).to eq(params[:end_date])
        expect(action.user).to eq(current_user)
        expect(action.rating).to be_nil
        expect(action.cancelled).to be_falsy
      end.to change { Reservation.count }.by(1)
    end
  end
end
