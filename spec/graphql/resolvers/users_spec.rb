# frozen_string_literal: true

require "rails_helper"

RSpec.describe Resolvers::Users, type: :query do
  before do
    @user_resolver = create_temporary_class 'UsersResolver' do
      include Resolvers::Users
    end
  end

  describe "users" do
    subject { @user_resolver.new().users(params)}

    context "when id is specified" do
      context "when user is found" do
        let(:params) { {id: user_1.id.to_s} }
        let(:user_1) { create(:user) }
        let(:user_2) { create(:user)}

        it { is_expected.to include(user_1) }
        it { is_expected.to_not include(user_2) }
      end

      context "when user is not found" do
        let(:params) { {id: "Nonexisting user id" } }

        it { is_expected.to be_empty }
      end
    end

    context "when id is not specified" do
      let(:params) { {} }
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user)}

      it { is_expected.to include(user_1).and include(user_2) }
    end
  end
end
