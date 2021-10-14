# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CreateUser" do
  subject do
    context = { current_user: current_user }
    result = ToptalReactBikesSchema.execute(query_string, context: context, variables: variables)
    result.to_h["data"]["createUser"]
  end

  let(:variables) do
    {
      "email": "a_totally_new_email@gmail.com",
      "admin": false,
      "password": "password"
    }
  end

  let(:query_string) do
    <<~GQL
      mutation createUser($email: String!, $admin: Boolean!, $password: String!){
        createUser(input: {email: $email,
                           admin: $admin,
                           password: $password}){
          user {
            id,
            email
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

      it "returns bike" do
        expect(subject["errors"]).not_to be_present
        expect(subject["user"]).to be_present
      end
    end
  end
end
