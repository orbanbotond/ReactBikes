# frozen_string_literal: true

require "rails_helper"

describe "users API endpoints" do
  let(:session_token) { "token-xxx123123" }
  let!(:user) { create :user, :admin, hashed_session_token: User.pwd_hash(session_token) }
  let(:developer_header) { { "X-Auth-Token" => session_token } }

  context "creates a user" do
    let(:params) { { email: "any@email.com", password: "pwd123123123123" } }
    let(:path) { "/api/users" }
    subject { post path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "invalid params" do
        context "email" do
          let(:params) { super().merge email: "Invalid Email" }

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
        expect_contains_field("email")
      end
    end
  end

  context "returns all the users" do
    let!(:user_1) { create :user }
    let!(:user_2) { create :user }
    let(:params) { {} }
    let(:path) { "/api/users" }
    subject { get path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_first_in_the_array_includes("id")
        expect_first_in_the_array_includes("email")
      end
    end
  end

  context "reservations of a user" do
    let!(:reservation) { create :reservation, user: user_2 }
    let(:user_2) { create :user }
    let(:params) { {} }
    let(:path) { "/api/users/#{user_2.id}/reservations" }
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

  context "returns a user" do
    let(:user_2) { create :user }
    let(:params) { {} }
    let(:path) { "/api/users/#{user_2.id}" }
    subject { get path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_contains_field("id")
        expect_contains_field("email")
      end
    end
  end

  context "deletes a user" do
    let(:user_2) { create :user }
    let(:params) { {} }
    let(:path) { "/api/users/#{user_2.id}" }
    subject { delete path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_contains_field("id")
        expect_contains_field("email")
      end
    end
  end

  context "updates a user" do
    let(:user_2) { create :user }
    let(:params) { { admin: true } }
    let(:path) { "/api/users/#{user_2.id}" }
    subject { put path, params: params, headers: developer_header }

    context "negative cases" do
      it_behaves_like "unauthenticated"

      context "invalid params" do
        # context 'admin' do
        #   let(:params) { {} }

        #   specify "Returns unauthorized" do
        #     expect_bad_request
        #     expect_json
        #   end
        # end
      end
    end

    context "positive cases" do
      specify "Returns success" do
        expect_success
        expect_json
        expect_contains_field("id")
        expect_contains_field("email")
      end
    end
  end
end
