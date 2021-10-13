# frozen_string_literal: true

require "rails_helper"

RSpec.describe "N+1 query test", :n_plus_one do
  let(:current_user) { create :user, admin: true }

  describe "for bikes/reservations" do
    populate do |n|
      n.times do
        user = create :user, email: "boti#{n}@gmail.com"
        create :reservation, user: user
      end
    end

    it "loads the reservations using one sql" do
      query_string = <<~GQL
          {
            bikes{
              nodes {
                id,
                model{
                  text
                },
                reservations {
                  id,
                  user {
                    email
                  }
                }
              }
            }
          }
      GQL

      expect do
        context = { current_user: current_user }
        ToptalReactBikesSchema.execute(query_string, context: context, variables: {})
      end.to perform_constant_number_of_queries
    end
  end

  describe "for users/reservations" do
    populate do |n|
      user = create :user, email: "boti#{n}@gmail.com"
      n.times do
        create :reservation, user: user
      end
    end

    it "loads the reservations using one sql" do
      query_string = <<~GQL
        {
          users{
            nodes{
              id,
              reservations{
                id,
                user {
                  email
                }
              }
            }
          }
        }
      GQL

      expect do
        context = { current_user: current_user }
        ToptalReactBikesSchema.execute(query_string, context: context, variables: {})
      end.to perform_constant_number_of_queries
    end
  end
end
