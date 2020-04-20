# frozen_string_literal: true

require "rails_helper"

describe Crud::Common::Delete, type: :model do
  context "positive case" do
    subject(:action) { described_class.as(:system).new(params) }
    let(:params) { { id: entity.id, ar_class: ar_class } }

    context "user class" do
      let(:ar_class) { :user }
      let!(:entity) { create :user, email: "test@email.com", hashed_password: User.pwd_hash("password") }

      it "destroys the entity" do
        expect do
          found_entity = action.perform!
          expect(found_entity).to be_a(User)
          expect(found_entity.id).to eq(params[:id])
        end.to change { User.count }.by(-1)
      end
    end

    context "bike class" do
      let(:ar_class) { :bike }
      let!(:entity) { create :bike }

      it "destroys the entity" do
        expect do
          found_entity = action.perform!
          expect(found_entity).to be_a(Bike)
          expect(found_entity.id).to eq(params[:id])
        end.to change { Bike.count }.by(-1)
      end
    end
  end

  context "validations" do
    context "attributes" do
      context "id" do
        it { is_expected.to validate_presence_of(:id) }
        it { is_expected.to_not allow_value("string id").for(:id) }
      end

      context "ar_class" do
        it { is_expected.to validate_presence_of(:ar_class) }
        it { is_expected.to validate_inclusion_of(:ar_class).in_array(%i(user bike bike_model reservation)) }
      end
    end
  end
end
