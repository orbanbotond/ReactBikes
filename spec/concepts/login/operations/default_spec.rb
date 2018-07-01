# frozen_string_literal: true

require "rails_helper"

describe Login::Operations::Default do
  let(:params) { { email: "n@email.com", password: "password" } }
  let!(:user) { create :user, email: params[:email], password: params[:password] }
  let(:additional_params) { {} }
  let(:result) { described_class.call(params, additional_params) }

  context "positive cases" do
    it "returns just the available bikes" do
      expect(result.success?).to eq(true)
      expect(result["model"]).to eq(user)
    end
  end
end
