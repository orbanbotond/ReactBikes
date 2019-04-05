# frozen_string_literal: true

require "rails_helper"

describe Entities::UserEntity do
  context "fields" do
    let(:user) { create :user }

    subject(:subject) { described_class.new(user) }

    specify "all the fields are presented" do
      json = subject.as_json

      [:id, :email, :admin].each do |field|
        expect(json.keys).to include(field)
      end
    end
  end
end
