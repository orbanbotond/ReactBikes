# frozen_string_literal: true

require "rails_helper"

describe Signup::Operations::Default do
  let(:result) { described_class.call params }
  let(:params) { { params: { email: "n@email.com", password: "password" } } }

  context "positive cases" do
    it "returns just the available bikes" do
      expect(result.success?).to eq(true)
      expect(result[:model]).to be_a(User)
      expect(result[:model].email).to eq(params[:params][:email])
      expect(result[:model].valid_password?(params[:params][:password])).to be_truthy
    end
  end
end
