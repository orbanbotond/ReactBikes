# frozen_string_literal: true

require "rails_helper"

describe Entities::BikeEntity do
  context "fields" do
    let(:bike) { create :bike }

    subject(:subject) { described_class.new(bike) }

    specify "all the fields are presented" do
      json = subject.as_json

      [:id, :weight, :color, :bike_model_id].each do |field|
        expect(json.keys).to include(field)
      end
    end
  end
end
