# frozen_string_literal: true

require "rails_helper"

describe Crud::Reservation::Contracts::Update do
  let(:reservation) { create :reservation }
  let(:contract) { described_class.new reservation  }
  let(:params) { { cancelled: true } }

  context "negative cases" do
    context "params are empty" do
      let(:params) { {} }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
      end
    end

    context "both rating and cancelled are there" do
      let(:params) { { rating: 4, cancelled: true } }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
      end
    end

    context "rating is out of range" do
      context "too low" do
        let(:params) { { rating: 0 } }

        it "fails validation" do
          expect(contract.validate params).to be_falsey
        end
      end

      context "too high" do
        let(:params) { { rating: 6 } }

        it "fails validation" do
          expect(contract.validate params).to be_falsey
        end
      end
    end
  end

  context "positive case" do
    context "cancelling" do
      it "passes validation" do
        expect(contract.validate params).to be_truthy
      end
    end

    context "rating is specified" do
      let(:params) { { rating: 3 } }

      it "fails validation" do
        expect(contract.validate params).to be_truthy
      end
    end
  end
end
