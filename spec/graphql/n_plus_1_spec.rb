# frozen_string_literal: true

require "rails_helper"

RSpec.describe "N+1 query test", :n_plus_one do
  let!(:model) { BikeModel.create text: "Mountain" }
  let!(:bike) { Bike.create weight: 1.2, color: Bike::COLORS.first, bike_model: model, latitude: 48.210033, longitude: 16.363449, average_rating: 1 }

  populate do |n|
    puts "Population: #{n}"
    n.times do
      user = User.create email: "boti#{n}@gmail.com"
      Reservation.create user: user, bike: bike
    end
  end

  it "loads the reservations" do
    query_string = <<~GQL
        {
          bikes{
            edges{
              node {
                id,
                model{
                  text
                },
                reservations {
                  cancelled,
                  user {
                    email
                  }
                }
              }
            }
          }
        }
      GQL

    expect do
      result = ToptalReactBikesSchema.execute(query_string, variables: {})
    # end.to perform_constant_number_of_queries.with_scale_factors(10, 100)
    end.to perform_constant_number_of_queries
  end
end
