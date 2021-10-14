# frozen_string_literal: true

require "rails_helper"

describe Crud::User::Update, type: :model do
  subject(:action) { described_class.as(current_user).new(params) }
  let(:current_user) { create :user, :admin }

  let!(:user) { create :user }
  let(:params) { { id: user.id, admin: true } }

  context "positive case" do
    it "returns the changed entity" do
      user = action.perform!
      expect(user.admin).to eq(params[:admin])
    end

    it { is_expected.to be_allowed }
  end

  describe "authorization" do
    context "when unauthorized" do
      let(:current_user) { create :user }

      it { is_expected.to_not be_allowed }
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
