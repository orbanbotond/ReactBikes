# frozen_string_literal: true

require "rails_helper"

describe User do
  context "fields" do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:admin) }
  end

  context "associations" do
    it { is_expected.to have_many(:reservations) }
  end
end
