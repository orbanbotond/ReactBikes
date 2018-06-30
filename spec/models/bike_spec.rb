# frozen_string_literal: true

require "rails_helper"

RSpec.describe Bike, type: :model do
  context "fields" do
    it { is_expected.to respond_to(:color) }
    it { is_expected.to respond_to(:weight) }
    it { is_expected.to respond_to(:latitude) }
    it { is_expected.to respond_to(:longitude) }
  end

  context "associations" do
    it { is_expected.to have_many(:reservations) }
    it { is_expected.to belong_to(:bike_model) }
  end
end
