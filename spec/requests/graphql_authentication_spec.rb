# frozen_string_literal: true

require "rails_helper"

# RSpec.describe GraphqlController, type: :controller do
RSpec.describe "GraphqlController authentication", type: :request do
  let(:session_token) { "token-xxx123123" }
  let!(:admin) { create :user, hashed_session_token: User.pwd_hash("token-xxx123123"), admin: true }
  let(:user) { create :user }
  let(:model) { create :bike_model, text: "Mountain" }
  let!(:bike) { create :bike, weight: 1.2, color: Bike::COLORS.first, bike_model: model, latitude: 48.210033, longitude: 16.363449, average_rating: 1 }
  let(:headers) { { "X-Auth-Token" => session_token } }
  let(:query_string) {
    <<~GQL
      {
        bikes{
          id,
        }
      }
    GQL
  }

  subject(:call_request) do
    post "/graphql", params: { query: query_string }, headers: headers
  end

  context "when unauthenticated" do
    let(:session_token) { "non_existent_sesstion_token" }

    it "returns 401" do
      call_request
      expect(response).to have_http_status(401)
      expect(response.content_type).to eq("application/json")
    end
  end

  context "unauthenticated" do
    it "executes the query successfull" do
      call_request
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("application/json")
    end
  end
end
