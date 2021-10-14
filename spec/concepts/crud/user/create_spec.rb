# frozen_string_literal: true

require "rails_helper"

describe Crud::User::Create, type: :model do
  let(:params) { { email: "nonexisting@gmail.com", password: "new_pwd" } }
  let!(:current_user) { create :user, :admin }
  subject(:action) { described_class.as(current_user).new(params) }

  context "positive case" do
    it "return the logged in user" do
      expect do
        user = action.perform!
        expect(user.email).to eq(params[:email])
      end.to change { User.count }.by(1)
    end
  end

  describe "authorization" do
    context "when unauthorized" do
      let(:current_user) { create :user }

      it { is_expected.to_not be_allowed }
    end
  end

  context "validations" do
    context "attributes" do
      context "email" do
        it { is_expected.to validate_presence_of(:email) }
      end

      context "password" do
        it { is_expected.to validate_presence_of(:password) }
      end
    end

    context "uniqueness of the email" do
      let!(:user) { create :user }
      let(:params) { super().merge(email: user.email) }

      it "will be invalid" do
        action.valid?
        expect(action.errors[:email]).to be_present
      end
    end
  end
end
