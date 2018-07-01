# frozen_string_literal: true

require "rails_helper"

describe Signup::Operations::Default do
  let(:additional_params) { {} }
  let(:result) { described_class.call(params, additional_params) }
  let(:params) { { email: "n@email.com", password: "password" } }

  context "positive cases" do
    it "returns just the available bikes" do
      binding.pry
      expect(result.success?).to eq(true)
      expect(result["model"]).to be_a(User)
      expect(result["model"].email).to eq(params[:email])
      expect(result["model"].password).to eq(params[:password])
    end
  end
end
