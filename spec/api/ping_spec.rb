# frozen_string_literal: true

require "rails_helper"

describe "GET /api/ping" do
  context "simple ping" do
    let(:path) { "/api/ping" }
    subject { get path, params: params, headers: developer_header }

    let(:params) { {} }
    let(:developer_header) { {} }

    specify "Returns success" do
      expect_success
      expect_json
    end
  end
end
