# frozen_string_literal: true

require "rails_helper"

RSpec.describe Reservation, type: :model do
  context "fields" do
    it { is_expected.to respond_to(:start_date) }
    it { is_expected.to respond_to(:end_date) }
    it { is_expected.to respond_to(:rating) }
    it { is_expected.to respond_to(:cancelled) }
  end

  context "associations" do
    it { is_expected.to belong_to(:bike) }
    it { is_expected.to belong_to(:user) }
  end
end
