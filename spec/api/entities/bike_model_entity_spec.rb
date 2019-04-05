# frozen_string_literal: true

require "rails_helper"

describe Entities::BikeModelEntity do
  context "fields" do
    let(:bike_model) { create :bike_model }

    subject(:subject) { described_class.new(bike_model) }

    specify "all the fields are presented" do
      json = subject.as_json

      [:id, :text].each do |field|
        expect(json.keys).to include(field)
      end
    end
  end
end
