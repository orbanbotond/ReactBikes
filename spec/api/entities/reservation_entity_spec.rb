# frozen_string_literal: true

require "rails_helper"

describe Entities::ReservationEntity do
  context "fields" do
    let(:reservation) { create :reservation }

    subject(:subject) { described_class.new(reservation) }

    specify "all the fields are presented" do
      json = subject.as_json

      [:id, :start_date, :end_date, :cancelled, :rating, :bike_id, :user_id].each do |field|
        expect(json.keys).to include(field)
      end
    end
  end
end
