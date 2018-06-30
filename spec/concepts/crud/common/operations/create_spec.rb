# frozen_string_literal: true

require "rails_helper"

describe Crud::Common::Operations::Create do
  let(:current_user) { create :user, :admin }
  let(:additional_params) { { "current_user" => current_user } }
  let(:result) { described_class.call(params, additional_params) }

  context "positive cases" do
    context "bikes" do
      let(:bike_model) { create :bike_model }
      let(:params) { { weight: 12, latitude: 54, longitude: 30, color: Bike::COLORS.first, bike_model_id: bike_model.id } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::Bike,
          "contract.default.class" => ::Crud::Bike::Contracts::Create
        )
      end

      it "create a new bike" do
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Bike)
          expect(result["model"].weight).to eq(params[:weight])
          expect(result["model"].latitude).to eq(params[:latitude])
          expect(result["model"].longitude).to eq(params[:longitude])
          expect(result["model"].color).to eq(params[:color])
          expect(result["model"].bike_model).to eq(bike_model)
        end.to change { Bike.count }.by(1)
      end
    end
  end
end
