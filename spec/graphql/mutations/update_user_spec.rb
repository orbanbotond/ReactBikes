# frozen_string_literal: true

require "rails_helper"

RSpec.describe "UpdateUser" do
  let(:user) { create :user }
  let(:user_id) { ToptalReactBikesSchema.id_from_object(user, user.class, {}) }

  subject do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]["updateUser"]
  end

  let(:variables) do
    {
      "userId": user_id,
      "email": "totally_new_email@gmail.com"
    }
  end

  let(:query_string) do
    <<~GQL
      mutation UpdateUsers($password: String, $admin: Boolean, $email: String, $userId: ID!){
        updateUser(input: {password: $password,
                           admin: $admin,
                           email: $email,
                           userId: $userId}){
          user {
            id,
          },
          errors,
        }
      }
    GQL
  end

  context "negative cases" do
    context "when not authenticated" do
      let(:current_user) { create :user }

      it "returns an error" do
        expect(subject["errors"]).to be_present
        expect(subject["user"]).not_to be_present
      end
    end
  end

  context "positive cases" do
    context "when authenticated" do
      let(:current_user) { create :user, :admin }

      it "returns user" do
        expect(subject["errors"]).not_to be_present
        expect(subject["user"]).to be_present
      end
    end
  end
end
