# frozen_string_literal: true

require "rails_helper"

RSpec.describe "DeleteUser" do
  let!(:user) { create :user }
  let(:user_id) { ToptalReactBikesSchema.id_from_object(user, user.class, {}) }

  subject(:scoped_reservations) do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]["deleteUser"]
  end

  let(:variables) do
    {
      "userId": user_id
    }
  end

  let(:query_string) do
    <<~GQL
      mutation DeleteUser($userId: ID!){
        deleteUser(input: {userId: $userId}){
          errors,
        }
      }
    GQL
  end

  context "negative cases" do
    context "when not authenticated" do
      let!(:current_user) { create :user }

      it "returns an error" do
        expect(subject["errors"]).to be_present
      end

      it "doesn't remove the user" do
        expect { subject }.to change { User.count }.by(0)
      end
    end
  end

  context "positive cases" do
    context "when authenticated" do
      let!(:current_user) { create :user, :admin }

      it "returns no error" do
        expect(subject["errors"]).not_to be_present
      end

      it "removes the user" do
        expect { subject }.to change { User.count }.by(-1)
      end
    end
  end
end
