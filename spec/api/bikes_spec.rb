# frozen_string_literal: true

require "rails_helper"

describe "bikes API endpoints" do
  let(:session_token) { "token-xxx123123" }
  let!(:user) { create :user, :admin, hashed_session_token: User.pwd_hash(session_token) }
  let(:developer_header) { { "X-Auth-Token" => session_token } }

  context "creates a bike" do
    let(:bike_model) { create :bike_model }
    let(:params) { { color: ::Bike::COLORS.first, weight: 12, latitude: 12.5, longitude: 13.6, bike_model_id: bike_model.id } }
    let(:path) { "/api/bikes" }
    subject { post path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "invalid params" do
        context "color" do
          let(:params) { super().merge color: "Invalid Color" }

          specify "Returns Bad Request" do
            expect_bad_request
            expect_json
          end
        end

        context "bike_model_id" do
          let(:params) { super().merge bike_model_id: -1 }

          specify "Returns unauthorized" do
            expect_bad_request
            expect_json
          end
        end
      end
    end

    context "positive cases" do
      specify "Returns created" do
        expect_created
        expect_json
        expect_contains_field("id")
        expect_contains_field("bike_model_id")
      end
    end
  end

  context "returns all the bikes" do
    let!(:bike_1) { create :bike }
    let!(:bike_2) { create :bike }
    let(:params) { {} }
    let(:path) { "/api/bikes" }
    subject { get path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_first_in_the_array_includes("id")
        expect_first_in_the_array_includes("bike_model_id")
      end
    end
  end

  context "reservations of a bike" do
    let!(:reservation) { create :reservation, bike: bike }
    let(:bike) { create :bike }
    let(:params) { {} }
    let(:path) { "/api/bikes/#{bike.id}/reservations" }
    subject { get path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_first_in_the_array_includes("id")
        expect_first_in_the_array_includes("rating")
      end
    end
  end

  context "returns a bike" do
    let(:bike) { create :bike }
    let(:params) { {} }
    let(:path) { "/api/bikes/#{bike.id}" }
    subject { get path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_contains_field("id")
        expect_contains_field("bike_model_id")
      end
    end
  end

  context "deletes a bike" do
    let(:bike) { create :bike }
    let(:params) { {} }
    let(:path) { "/api/bikes/#{bike.id}" }
    subject { delete path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_contains_field("id")
        expect_contains_field("bike_model_id")
      end
    end
  end

  context "updates a bike" do
    let(:bike) { create :bike }
    let(:params) { {} }
    let(:path) { "/api/bikes/#{bike.id}" }
    subject { put path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "invalid params" do
        context "color" do
          let(:params) { super().merge color: "Invalid Color" }

          specify "Returns unauthorized" do
            expect_bad_request
            expect_json
          end
        end

        context "bike_model_id" do
          let(:params) { super().merge bike_model_id: -1 }

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
        expect_contains_field("bike_model_id")
      end
    end
  end
end
