# frozen_string_literal: true

require "rails_helper"

describe Crud::Bike::Contracts::Update do
  let(:contract) { described_class.new Bike.new }
  let(:params) { { weight: 12, latitude: 54, longitude: 30, color: ::Bike::COLORS.first } }

  context "negative cases" do
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

    it "partial params validation" do
      expect(contract.validate params.slice(:weight)).to be_truthy
    end
  end
end
