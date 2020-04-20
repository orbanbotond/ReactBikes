# frozen_string_literal: true

require "rails_helper"

describe Signup::Action, type: :model do
  let(:params) { { email: "n@email.com", password: "password" } }
  subject(:action) { described_class.as(:system).new(params) }
  let!(:user) { create :user }

  context "positive case" do
    it "return the signed up user" do
      expect do
        active_user = action.perform!
        expect(active_user).to be_a(User)
        expect(active_user.email).to eq(params[:email])
        expect(active_user.valid_password?(params[:password])).to be_truthy
      end.to change { User.count }.by(1)
    end
  end

  context "validations" do
    context "attributes" do
      context "email" do
        it { is_expected.to allow_value(params[:email]).for(:email) }
        it { is_expected.to validate_presence_of(:email) }
        it { is_expected.to_not allow_value("invalid_email_format").for(:email).with_message("is invalid") }
      end

      context "password" do
        it { is_expected.to allow_value(params[:password]).for(:password) }
        it { is_expected.to validate_presence_of(:password) }
      end
    end

    context "already existing email" do
      let(:params) { { email: user.email, password: "invalid_password" } }

      it { is_expected.to_not be_valid }
      it "contains an error msg for the password" do
        action.valid?
        expect(action.errors[:email]).to be_present
      end
    end
  end
end
