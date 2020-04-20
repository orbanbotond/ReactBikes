# frozen_string_literal: true

require "rails_helper"

describe Crud::User::Update, type: :model do
  subject(:action) { described_class.as(:system).new(params) }

  let!(:user) { create :user }
  let(:params) { { id: user.id, admin: true } }

  context "positive case" do
    it "returns the changed entity" do
      expect do
        user = action.perform!
        expect(user.admin).to eq(params[:admin])
      end.to change { User.count }.by(0)
    end
  end

  context "validations" do
    context "attributes" do
      context "id" do
        it { is_expected.to validate_presence_of(:id) }
      end
    end
  end
end
