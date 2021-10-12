# frozen_string_literal: true

RSpec.shared_examples "unauthenticated" do
  context "missing token" do
    let(:developer_header) { super().except("X-Auth-Token") }

    specify "returns unauthorized" do
      expect_unauthorized
      expect_json
    end
  end

  context "bad token" do
    let(:developer_header) { super().merge "X-Auth-Token" => "wrong token" }

    specify "returns unauthorized" do
      expect_unauthorized
      expect_json
    end
  end
end
