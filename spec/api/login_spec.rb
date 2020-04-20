# frozen_string_literal: true

require "rails_helper"

describe "POST /api/login" do
  let(:path) { "/api/login" }
  subject { post path, params: params, headers: developer_header }
  let(:pwd) { "pwd123123123" }
  let(:user) { create :user, password: pwd }
  let(:params) { { email: user.email, password: pwd } }
  let(:developer_header) { {} }

  context "negative cases" do
    context "wrong pwd" do
      let(:params) { super().merge password: "wrong" }

      specify "Returns unauthorized" do
        expect_unauthorized
        expect_json
      end
    end

    context "wrong email" do
      context "wrong format" do
        let(:params) { super().merge email: "not_existent@gmail.com" }

        specify "Returns unauthorized" do
          expect_bad_request
          expect_json
        end
      end

      context "not existent format" do
        let(:params) { super().merge password: "bad_pwd" }

        specify "Returns unauthorized" do
          expect_unauthorized
          expect_json
        end
      end
    end
  end

  context "positive cases" do
    specify "Returns authorized" do
      expect_created
      expect_json
      expect_contains_field("session_token")
    end
  end
end
