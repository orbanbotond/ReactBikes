# frozen_string_literal: true

require "rails_helper"

describe Crud::Contracts::UpdateBike do
  let(:contract) { described_class.new Bike.new }
  let(:params) { { weight: 12, latitude: 54, longitude: 30, color: Bike::COLORS.first} }

  context "positive case" do
    it "passes validation" do
      expect(contract.validate params).to be_truthy
    end

    it "partial params validation" do
      expect(contract.validate params.slice(:weight)).to be_truthy
    end
  end
end
