# frozen_string_literal: true

require "rails_helper"

describe "GET /api/bike_models" do
  let(:path) { "/api/bike_models" }
  subject { get path, params: params, headers: developer_header }
  let(:session_token) { 'token-xxx123123' }
  let!(:user) { create :user, hashed_session_token: User.pwd_hash(session_token) }
  let(:params) { {} }
  let(:developer_header) { {"X-Auth-Token" => session_token} }

  context "negative cases" do
    context 'token is missing' do
      let(:developer_header) { {} }

      specify "Returns Unauthorized" do
        expect_unauthorized
        expect_json
      end
    end

    context 'token is bad' do
      let(:developer_header) { super().merge "X-Auth-Token"=> "wrong token" }

      specify "Returns Unauthorized" do
        expect_unauthorized
        expect_json
      end
    end
  end

  context 'positive cases' do
    let!(:model_1) {create :bike_model}
    let!(:model_2) {create :bike_model}

    specify "Returns success" do
      expect_success
      expect_json
    end
  end
end
