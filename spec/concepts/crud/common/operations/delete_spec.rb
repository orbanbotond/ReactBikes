# frozen_string_literal: true

require "rails_helper"

describe Crud::Common::Operations::Delete do
  let(:current_user) { create :user, :admin }
  let(:additional_params) { { "current_user" => current_user } }
  let(:result) { described_class.call(params, additional_params) }

  context "positive cases" do
    context "bikes" do
      let(:model) { create :bike }
      let(:params) { { id: model.id } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::Bike
        )
      end

      it "destroys the bike" do
        params
        additional_params

        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Bike)
          expect(result["model"].id).to eq(params[:id])
        end.to change { Bike.count }.by(-1)
      end
    end

    context "users" do
      let(:model) { create :user }
      let(:params) { { id: model.id } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::User
        )
      end

      it "reads the user" do
        params
        additional_params
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(User)
          expect(result["model"].id).to eq(params[:id])
        end.to change { User.count }.by(-1)
      end
    end

    context "reservations" do
      let(:model) { create :reservation }
      let(:params) { { id: model.id } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::Reservation
        )
      end

      it "reads the reservation" do
        params
        additional_params
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Reservation)
          expect(result["model"].id).to eq(params[:id])
        end.to change { Reservation.count }.by(-1)
      end
    end
  end
end
