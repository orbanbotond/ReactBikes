# frozen_string_literal: true

require "rails_helper"

describe Crud::Common::Operations::Update do
  let(:current_user) { create :user, :admin }
  let(:additional_params) { { "current_user" => current_user } }
  let(:result) { described_class.call(params, additional_params) }

  context "positive cases" do
    context "bikes" do
      let(:model) { create :bike }
      let(:bike_model) { create :bike_model }
      let(:params) { { id: model.id, weight: 12, latitude: 54, longitude: 30, color: ::Bike::COLORS.first, bike_model_id: bike_model.id } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::Bike,
          "contract.default.class" => ::Crud::Bike::Contracts::Update
        )
      end

      it "updates the old bike" do
        params
        additional_params

        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Bike)
          expect(result["model"].weight).to eq(params[:weight])
          expect(result["model"].latitude).to eq(params[:latitude])
          expect(result["model"].longitude).to eq(params[:longitude])
          expect(result["model"].color).to eq(params[:color])
          expect(result["model"].bike_model).to eq(bike_model)
        end.to_not change { Bike.count }
      end
    end

    context "users" do
      let(:model) { create :user }
      let(:params) { { id: model.id, admin: true } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::User,
          "contract.default.class" => ::Crud::User::Contracts::Update
        )
      end

      it "updates the old user" do
        params
        additional_params
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(User)
          expect(result["model"].admin).to eq(params[:admin])
        end.to_not change { User.count }
      end
    end

    context "reservation" do
      let(:model) { create :reservation }
      let(:params) { { id: model.id, rating: 5 } }
      let(:additional_params) do
        super().merge(
          "model.class" => ::Reservation,
          "contract.default.class" => ::Crud::Reservation::Contracts::Update
        )
      end

      it "updates the old model" do
        params
        additional_params
        expect do
          expect(result.success?).to eq(true)
          expect(result["model"]).to be_a(Reservation)
          expect(result["model"].rating).to eq(params[:rating])
        end.to_not change { Reservation.count }
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
