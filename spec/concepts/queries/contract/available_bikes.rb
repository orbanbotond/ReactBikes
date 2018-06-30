# frozen_string_literal: true

require "rails_helper"

describe AvailableBikes::Contracts::Query do
  let(:contract) { described_class.new({}) }
  let(:params) { attributes_for(:reservation).slice(:start_date, :end_date) }

  context "negative cases" do
    context "start_date is in the past" do
      let(:params) { super().merge(start_date: 1.day.ago.to_datetime) }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
      end
    end

    context "end_date is in the past" do
      let(:params) { super().merge(end_date: 1.day.ago.to_datetime) }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
      end
    end

    context "end_date is before the start_date" do
      let(:params) { super().merge(end_date: 1.day.from_now.to_datetime) }

      it "fails validation" do
        expect(contract.validate params).to be_falsey
      end
    end

    [:start_date, :end_date].each do |field|
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
  end

  context "positive case" do
    context "other fields are specified" do
      let!(:model) { create :bike_model }
      let(:param) { super().merge(color: ::Bike::COLORS.first, bike_model_id: model.id, weight: 1.2, rating: 3) }

      it "passes validation" do
        expect(contract.validate params).to be_truthy
      end
    end

    it "passes validation" do
      expect(contract.validate params).to be_truthy
    end
  end
end
