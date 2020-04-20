# frozen_string_literal: true

require "rails_helper"

describe Crud::Bike::Create, type: :model do
  let(:params) { { color: ::Bike::COLORS.first, weight: 1.2, latitude: 0, longitude: 0, bike_model_id: bike_model.id } }
  subject(:action) { described_class.as(:system).new(params) }
  let!(:bike_model) { create :bike_model }

  context "positive case" do
    it "return the logged in user" do
      expect do
        bike = action.perform!
        expect(bike.color).to eq(params[:color])
        expect(bike.weight).to eq(params[:weight])
        expect(bike.latitude).to eq(params[:latitude])
        expect(bike.longitude).to eq(params[:longitude])
      end.to change { Bike.count }.by(1)
    end
  end

  context "validations" do
    context "attributes" do
      context "color" do
        it { is_expected.to validate_presence_of(:color) }
        it { is_expected.to validate_inclusion_of(:color).in_array(::Bike::COLORS) }
      end

      context "latitude" do
        it { is_expected.to validate_presence_of(:latitude) }
        it { is_expected.to allow_value(1.2).for(:latitude) }
        it { is_expected.to_not allow_value("invalid latitude").for(:latitude) }
      end

      context "longitude" do
        it { is_expected.to validate_presence_of(:longitude) }
        it { is_expected.to allow_value(1.2).for(:longitude) }
        it { is_expected.to_not allow_value("invalid longitude").for(:longitude) }
      end

      context "weight" do
        it { is_expected.to validate_presence_of(:weight) }
        it { is_expected.to allow_value(1.2).for(:weight) }
        it { is_expected.to_not allow_value("invalid weight").for(:weight) }
      end
    end

    context "bike_model_id" do
      let(:params) { super().merge(bike_model_id: -1) }

      it "will be invalid" do
        action.valid?
        expect(action.errors[:bike_model_id]).to be_present
      end
    end
  end
end
