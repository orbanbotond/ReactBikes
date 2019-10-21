# frozen_string_literal: true

require "rails_helper"

describe Queries::Operations::AvailableBikes do
  let(:current_user) { create :user, :admin }
  let(:additional_params) { { "current_user" => current_user } }
  let(:result) { described_class.call({ params: params }.merge additional_params) }

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
      expect(result.success?).to eq(true)
      expect(result[:model]).to_not include(bike_n_01)
      expect(result[:model]).to_not include(bike_n_02)
      expect(result[:model]).to include(bike_p_01)
      expect(result[:model]).to include(bike_p_02)
      expect(result[:model]).to include(bike_p_03)
    end
  end

  context "refined search color" do
    let(:params) { super().merge(color: ::Bike::COLORS.first) }

    it "returns just the available bikes" do
      expect(result.success?).to eq(true)
      expect(result[:model]).to_not include(bike_n_01)
      expect(result[:model]).to_not include(bike_n_02)
      expect(result[:model]).to_not include(bike_p_01)
      expect(result[:model]).to_not include(bike_p_03)

      expect(result[:model]).to include(bike_p_02)
    end
  end
  context "refined search weight" do
    let(:params) { super().merge(weight: 1.2) }

    it "returns just the available bikes" do
      expect(result.success?).to eq(true)
      expect(result[:model]).to_not include(bike_n_01)
      expect(result[:model]).to_not include(bike_n_02)
      expect(result[:model]).to_not include(bike_p_01)
      expect(result[:model]).to_not include(bike_p_02)

      expect(result[:model]).to include(bike_p_03)
    end
  end

  context "refined search rating" do
    let(:params) { super().merge(rating: 5) }

    it "returns just the available bikes" do
      expect(result.success?).to eq(true)
      expect(result[:model]).to_not include(bike_n_01)
      expect(result[:model]).to_not include(bike_n_02)
      expect(result[:model]).to_not include(bike_p_02)
      expect(result[:model]).to_not include(bike_p_03)

      expect(result[:model]).to include(bike_p_01)
    end
  end

  context "refined search model" do
    let(:params) { super().merge(bike_model_id: bike_p_01.bike_model.id) }

    it "returns just the available bikes" do
      expect(result.success?).to eq(true)
      expect(result[:model]).to_not include(bike_n_01)
      expect(result[:model]).to_not include(bike_n_02)
      expect(result[:model]).to_not include(bike_p_02)
      expect(result[:model]).to_not include(bike_p_03)

      expect(result[:model]).to include(bike_p_01)
    end
  end
end
