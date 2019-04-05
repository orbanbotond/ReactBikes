# frozen_string_literal: true

require "rails_helper"

describe Crud::Bike::Contracts::Create do
  let(:contract) { described_class.new Bike.new }
  let!(:bike_model) { create :bike_model }
  let(:params) { { weight: 12, latitude: 54, longitude: 30, color: Bike::COLORS.first, bike_model_id: bike_model.id } }

  context "negative cases" do
    [:color, :weight, :latitude, :longitude, :bike_model_id].each do |field|
      context "#{field} is missing" do
        let(:params) { super().except(field) }

        it "fails validation" do
          expect(contract.validate params).to be_falsey
        end
      end

      context "#{field} is empty" do
        let(:params) { super().merge(field => "") }

        it "fails validation" do
          expect(contract.validate params).to be_falsey
        end
      end
    end

    context "bike_model_id is invalid" do
      let(:params) { super().merge(bike_model_id: -1) }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
        expect(contract.errors[:bike_model_id]).to be_present
      end
    end
  end

  context "positive case" do
    it "passes validation" do
      expect(contract.validate params).to be_truthy
    end
  end
end
