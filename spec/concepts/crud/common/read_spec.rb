# frozen_string_literal: true

require "rails_helper"

describe Crud::Common::Read, type: :model do
  context "positive case" do
    subject(:action) { described_class.as(:system).new(params) }
    let(:params) { { id: entity.id, ar_class: ar_class } }

    context "user class" do
      let(:ar_class) { :user }
      let!(:entity) { create :user, email: "test@email.com", hashed_password: User.pwd_hash("password") }

      it "returns the entity" do
        found_entity = action.perform!
        expect(found_entity).to eq(entity)
      end
    end

    context "bike class" do
      let(:ar_class) { :bike }
      let!(:entity) { create :bike }

      it "returns the entity" do
        found_entity = action.perform!
        expect(found_entity).to eq(entity)
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
