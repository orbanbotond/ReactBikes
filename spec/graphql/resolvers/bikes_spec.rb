# frozen_string_literal: true

require "rails_helper"

RSpec.describe Resolvers::Bikes, type: :query do
  before do
    @bike_resolver = create_temporary_class 'BikesResolver' do
      include Resolvers::Bikes
    end
  end

  describe "bikes" do
    subject { @bike_resolver.new().bikes(params)}

    context "when id is specified" do
      context "when bike is found" do
        let(:params) { {id: bike_1.id.to_s} }
        let(:bike_1) { create(:bike, average_rating: 5) }
        let(:bike_2) { create(:bike, average_rating: 4)}

        it { is_expected.to include(bike_1) }
        it { is_expected.to_not include(bike_2) }
      end

      context "when bike is not found" do
        let(:params) { {id: "Nonexisting bike id" } }

        it { is_expected.to be_empty }
      end
    end

    context "when id is not specified" do
      let(:params) { {} }
      let(:bike_1) { create(:bike, average_rating: 5) }
      let(:bike_2) { create(:bike, average_rating: 4)}

      it { is_expected.to include(bike_1).and include(bike_2) }
    end
  end
end
