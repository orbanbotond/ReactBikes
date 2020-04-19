# frozen_string_literal: true

require "rails_helper"

describe Crud::Bike::Update, type: :model do
  let(:params) { { id: bike.id, color: ::Bike::COLORS.last, longitude:0, bike_model_id: bike_model.id } }
  subject(:action) { described_class.as(:system).new(params) }
  let!(:bike_model) { create :bike_model }
  let!(:bike) { create :bike }

  context "positive case" do
    it "return the updated bike" do
      expect do
        bike = action.perform!
        expect(bike.color).to eq(params[:color])
        expect(bike.longitude).to eq(params[:longitude])
        expect(bike.bike_model_id).to eq(params[:bike_model_id])
        expect(bike.id).to eq(params[:id])
      end.to change { Bike.count }.by(0)
    end
  end

  context "validations" do
    context "attributes" do
      context "color" do
        it { is_expected.to validate_inclusion_of(:color).in_array(::Bike::COLORS) }
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
