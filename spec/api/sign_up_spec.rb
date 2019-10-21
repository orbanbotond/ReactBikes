# frozen_string_literal: true

require "rails_helper"

describe "POST /api/signup" do
  let(:path) { "/api/signup" }
  subject { post path, params: params, headers: developer_header }
  let(:user) { create :user }
  let(:params) { { email: "new_email@gmail.com", password: "pwd123123123" } }
  let(:developer_header) { {} }

  context "negative cases" do
    context "already taken email" do
      let(:params) { super().merge email: user.email }

      specify "Returns bad request" do
        expect_bad_request
        expect_json
      end
    end

    context "wrong email" do
      context "wrong format" do
        let(:params) { super().merge email: "not_existent" }

        specify "Returns unauthorized" do
          expect_bad_request
          expect_json
        end
      end
    end
  end

  context "positive cases" do
    specify "Returns authorized" do
      expect_created
      expect_json
    end
  end
end
