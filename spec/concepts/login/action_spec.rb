# frozen_string_literal: true

require "rails_helper"

describe Login::Action, type: :model do
  let(:params) { { email: "n@email.com", password: "password" } }
  subject(:action) { described_class.as(:system).new(params) }
  let!(:user) { create :user, email: params[:email], hashed_password: User.pwd_hash("password") }

  context "positive case" do
    it "return the logged in user" do
      expect do
        active_user = action.perform!
        expect(active_user).to eq(user)
        expect(User.pwd_hash(active_user.session_token)).to eq(active_user.hashed_session_token)
      end.to change { user.reload.hashed_session_token }
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

    context "email/pwd does not match" do
      let(:params) { { email: "n@email.com", password: "invalid_password" } }

      it { is_expected.to_not be_valid }
      it "contains an error msg for the password" do
        action.valid?
        expect(action.errors[:password]).to be_present
      end
    end
  end
end
