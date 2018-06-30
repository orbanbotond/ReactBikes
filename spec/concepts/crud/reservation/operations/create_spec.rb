# frozen_string_literal: true

require "rails_helper"

describe Crud::Reservation::Operations::Create do
  let(:current_user) { create :user, :admin }
  let(:additional_params) { { "current_user" => current_user } }
  let(:result) { described_class.call(params, additional_params) }

  context "positive cases" do
    context "reservation" do
      let!(:bike) { create :bike }
      let(:params) do
        attributes_for(:reservation)
        .slice(:start_date, :end_date)
        .merge(bike_id: bike.id)
      end
      let(:additional_params) do
        super().merge(
          "model.class" => ::Reservation,
          "contract.default.class" => ::Crud::Reservation::Contracts::Create
        )
      end

      it "create a new reservation" do
        params
        additional_params
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Reservation)
          expect(result["model"].start_date).to eq(params[:start_date])
          expect(result["model"].end_date).to eq(params[:end_date])
          expect(result["model"].user).to eq(current_user)
          expect(result["model"].rating).to be_nil
          expect(result["model"].cancelled).to be_falsy
        end.to change { Reservation.count }.by(1)
      end
    end
  end
end
