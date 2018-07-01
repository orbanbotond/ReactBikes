# frozen_string_literal: true

require "rails_helper"

describe Crud::Reservation::Operations::Update do
  let(:current_user) { create :user, :admin }
  let(:additional_params) { { "current_user" => current_user } }
  let(:result) { described_class.call(params, additional_params) }

  context "positive cases" do
    context "reservation" do
      let(:model) { create :reservation }
      let(:params) { { id: model.id, rating: 5 } }

      it "updates the old model" do
        params
        additional_params
        expect do
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Reservation)
          expect(result["model"].rating).to eq(params[:rating])
          expect(result["model"].bike.average_rating).to eq(params[:rating])
        end.to_not change { Reservation.count }
        end.to change { model.bike.reload.average_rating }
      end

      context "cancells" do
        let(:params) { { id: model.id, cancelled: true } }

        it "cancells" do
          params
          additional_params
          expect do
            expect(result.success?).to eq(true)
            expect(result["model"]).to be_a(Reservation)
            expect(result["model"].cancelled).to eq(params[:cancelled])
          end.to_not change { Reservation.count }
        end
      end
    end
  end
end
