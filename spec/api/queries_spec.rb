# frozen_string_literal: true

require "rails_helper"

describe "queries API endpoints" do
  let(:session_token) { "token-xxx123123" }
  let!(:user) { create :user, hashed_session_token: User.pwd_hash(session_token) }
  let(:developer_header) { { "X-Auth-Token" => session_token } }
  let!(:bike) { create :bike }

  context "queries" do
    let(:params) { { start_date: 1.day.from_now.to_s, end_date: 2.days.from_now.to_s } }
    let(:path) { "/api/queries/available_bikes" }
    subject { get path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "missing start_data" do
        let(:params) { super().except :start_date }

        specify "Returns bad request" do
          expect_bad_request
          expect_json
        end
      end
    end

    context "positive cases" do
      specify "Returns created" do
        expect_success
        expect_json
        expect_first_in_the_array_includes("id")
        expect_first_in_the_array_includes("bike_model_id")
      end
    end
  end
end
