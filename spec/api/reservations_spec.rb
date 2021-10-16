# frozen_string_literal: true

require "rails_helper"

describe "reservations API endpoints" do
  let(:session_token) { "token-xxx123123" }
  let!(:user) { create :user, :admin, hashed_session_token: User.pwd_hash(session_token) }
  let(:developer_header) { { "X-Auth-Token" => session_token } }
  let(:bike) { create :bike }

  context "creates a reservation" do
    let(:params) { { start_date: 1.day.from_now.to_s, end_date: 2.days.from_now.to_s, bike_id: bike.id } }
    let(:path) { "/api/reservations" }
    subject { post path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "missing bike_id" do
        let(:params) { super().except :bike_id }

        specify "Returns unauthorized" do
          expect_bad_request
          expect_json
        end
      end
    end

    context "positive cases" do
      specify "Returns created" do
        expect_created
        expect_json
        expect_contains_field("id")
        expect_contains_field("start_date")
        expect_contains_field("end_date")
      end
    end
  end

  context "updates a reservation" do
    let!(:reservation) { create :reservation }
    let(:params) { { rating: 4 } }
    let(:path) { "/api/reservations/#{reservation.id}" }
    subject { put path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "invalid params" do
        context "admin" do
          let(:params) { { cancelled: true, rating: 5 } }

          specify "Returns unauthorized" do
            expect_bad_request
            expect_json
          end
        end
      end
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_contains_field("id")
        expect_contains_field("start_date")
        expect_contains_field("end_date")
      end
    end
  end
end
