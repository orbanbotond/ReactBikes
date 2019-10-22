# frozen_string_literal: true

require "rails_helper"

describe Login::Operations::Default do
  let(:params) { { email: "n@email.com", password: "password" } }
  let!(:user) { create :user, email: params[:email], hashed_password: User.pwd_hash(params[:password]) }
  let(:additional_params) { {} }
  let(:result) { described_class.call({ params: params }.merge additional_params) }

  context "positive cases" do
    it "returns the logged in user" do
      expect do
        expect(result.success?).to eq(true)
        expect(result[:model]).to eq(user)
        expect(User.pwd_hash(result[:model].session_token)).to eq(result[:model].hashed_session_token)
      end.to change { user.reload.hashed_session_token }
    end
  end
end
