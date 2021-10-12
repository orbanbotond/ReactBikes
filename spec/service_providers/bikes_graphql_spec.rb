# frozen_string_literal: true

require_relative "./pact_helper"
require_relative "./bike_graphql_client"
require "rspec/json_expectations"
require "graphql/schema/unique_within_type"

describe BikeGraphqlClient, pact: true do
  before do
    BikeGraphqlClient.base_uri "localhost:1234"
  end

  let(:session_token) { "token-xxx123123" }
  let(:variables) { {} }

  subject { BikeGraphqlClient.new(session_token) }

  let!(:initialization) do
    bikes_graphql_query.given(provider_state).
      upon_receiving(message_description).
      with(method: :post,
           path: "/graphql",
           body: payload,
           headers: { "X-Auth-Token" => session_token, "Content-Type" => "application/json" }).
      will_respond_with(
        status: 200,
        headers: { "Content-Type" => "application/json; charset=utf-8" },
        body: mocked_body_content
      )
  end

  let(:payload) do
    {
      "query" => gql,
      "variables" => variables
    }
  end

  describe "mutations" do
    describe "bikes" do
      context "when creating them" do
        let(:bike_model) { build_stubbed :bike_model }
        let(:variables) do
          {
            "color": "red",
            "weight": 3.5,
            "bikeModelId": GraphQL::Schema::UniqueWithinType.encode("BikeModel", 1),
            "latitude": 23.15,
            "longitude": 35.38
          }
        end

        let(:gql) do
          <<~GQL
            mutation createBikes($color: BikeColorsEnum!, $weight: Float!, $latitude: Float!, $longitude: Float!, $bikeModelId: ID!){
              createBike(input: {color: $color,
                                 weight: $weight,
                                 latitude: $latitude,
                                 longitude: $longitude,
                                 bikeModelId: $bikeModelId}){
                bike {
                  id
                },
                errors,
              }
            }
          GQL
        end
        let(:provider_state) { "a bike model exists" }
        let(:message_description) { "a request for bike creation" }
        let(:mocked_body_content) do
          {
            data: {
              createBike: {
                bike: {
                  id: Pact.like("1"),
                },
                errors: []
              }
            }
          }
        end

        it "returns a bike" do
          expect(JSON.parse(subject.create_bike.body, { symbolize_names: true })[:data]).to include_json(
            createBike: {
              bike: {
                id: /\d/,
              },
              errors: []
            }
          )
        end
      end

      context "when updating them" do
        let(:bike) { build_stubbed :bike }
        let(:variables) do
          {
            "color": "blue",
            "weight": 4.5,
            "bikeId": GraphQL::Schema::UniqueWithinType.encode("Bike", 1)
          }
        end

        let(:gql) do
          <<~GQL
            mutation updateBike($color: BikeColorsEnum!, $weight: Float!, $bikeId: ID!){
              updateBike(input: {color: $color,
                                 weight: $weight,
                                 bikeId: $bikeId}){
                bike {
                  id,
                  color,
                  weight
                },
                errors,
              }
            }
          GQL
        end
        let(:provider_state) { "a red bike model exists" }
        let(:message_description) { "a request for bike update" }
        let(:mocked_body_content) do
          {
            data: {
              updateBike: {
                bike: {
                  id: Pact.like("1"),
                  color: "blue",
                  weight: 4.5
                },
                errors: []
              }
            }
          }
        end

        it "returns the updated bike" do
          expect(JSON.parse(subject.update_bike.body, { symbolize_names: true })[:data]).to include_json(
            updateBike: {
              bike: {
                id: /\d/,
                color: "blue",
                weight: 4.5,
              },
              errors: []
            }
          )
        end
      end
    end
  end

  describe "queries" do
    describe "get users" do
      context "when querying the users with their reservations" do
        let(:gql) do
          <<~GQL
            {
              users{
                nodes{
                  id,
                  reservations{
                    id,
                  }
                }
              }
            }
          GQL
        end
        let(:provider_state) { "a user with reservation exists" }
        let(:message_description) { "a request for users with reservations" }
        let(:mocked_body_content) do
          {
            data: {
              users: {
                nodes: [{
                  id: Pact.like("1"),
                  reservations: [{
                    id: Pact.like("1"),
                  }]
                }]
              }
            }
          }
        end

        it "returns users" do
          expect(JSON.parse(subject.get_users_with_reservations.body, { symbolize_names: true })[:data]).to include_json(
            users: {
              nodes: UnorderedArray({
                id: /\d*/,
                reservations: UnorderedArray({
                  id: /\d*/,
                })
              })
            }
          )
        end
      end

      context "pagination" do
        let(:gql) do
          <<~GQL
            {
              users{
                edges{
                  cursor,
                },
                pageInfo {
                  endCursor,
                  hasNextPage,
                  hasPreviousPage,
                  startCursor,
                },
                totalCount,
              },
            }
          GQL
        end
        let(:provider_state) { "a user exists" }
        let(:message_description) { "a paginated request for users" }
        let(:mocked_body_content) do
          {
            data: {
              users: {
                edges: [{
                  cursor: Pact.like("cursor"),
                }],
                pageInfo: {
                  endCursor: Pact.like("cursor"),
                  startCursor: Pact.like("cursor"),
                  hasNextPage: Pact.like(true),
                  hasPreviousPage: Pact.like(true),
                },
                totalCount: Pact.like(1),
              }
            }
          }
        end

        it "returns users" do
          expect(JSON.parse(subject.get_users_with_pagination_info.body, { symbolize_names: true })[:data]).to include_json(
            users: {
              edges: UnorderedArray({
                cursor: /\.*/,
              }),
              pageInfo: {
                endCursor: /\.*/,
                startCursor: /\.*/,
                hasNextPage: /\.*/,
                hasPreviousPage: /\.*/,
              },
              totalCount: /\d/
            }
          )
        end
      end
    end

    describe "get bikes" do
      context "when querying the bikes with their reservations and models" do
        let(:gql) do
          <<~GQL
            {
              bikes{
                edges{
                  node {
                    id,
                    model{
                      text,
                    },
                    reservations {
                      cancelled,
                      user {
                        email,
                      }
                    }
                  }
                }
              }
            }
          GQL
        end
        let(:provider_state) { "a bike with reservation exists" }
        let(:message_description) { "a request for bikes with reservations and models" }
        let(:mocked_body_content) do
          {
            data: {
              bikes: {
                edges: [{
                  node: {
                    id: Pact.like("1"),
                    model: {
                      text: Pact.like("Mountain")
                    },
                    reservations: [{
                      cancelled: false,
                      user: {
                        "email": Pact.like("boti@toptal.com")
                      }
                    }]
                  }
                }]
              }
            }
          }
        end

        it "returns bikes" do
          expect(JSON.parse(subject.get_bikes_with_reservations_and_models.body, { symbolize_names: true })[:data]).to include_json(
            bikes: {
              edges: UnorderedArray({
                node: {
                  id: /\d/,
                  model: {
                    text: /\.*/
                  },
                  reservations: UnorderedArray({
                    cancelled: false,
                    user: {
                      email: /\.*/
                    }
                  })
                }
              })
            }
          )
        end
      end

      context "pagination" do
        let(:gql) do
          <<~GQL
            {
              bikes{
                edges{
                  cursor,
                },
                pageInfo {
                  endCursor,
                  hasNextPage,
                  hasPreviousPage,
                  startCursor,
                },
                totalCount,
              }
            }
          GQL
        end
        let(:provider_state) { "a bike exists" }
        let(:message_description) { "a paginated request for bikes" }
        let(:mocked_body_content) do
          {
            data: {
              bikes: {
                edges: [{
                  cursor: Pact.like("cursor"),
                }],
                pageInfo: {
                  endCursor: Pact.like("cursor"),
                  startCursor: Pact.like("cursor"),
                  hasNextPage: Pact.like(true),
                  hasPreviousPage: Pact.like(true),
                },
                totalCount: Pact.like(1),
              }
            }
          }
        end

        it "returns bikes" do
          expect(JSON.parse(subject.get_bikes_with_pagination_info.body, { symbolize_names: true })[:data]).to include_json(
            bikes: {
              edges: UnorderedArray({
                cursor: /\.*/,
              }),
              pageInfo: {
                endCursor: /\.*/,
                startCursor: /\.*/,
                hasNextPage: /\.*/,
                hasPreviousPage: /\.*/,
              },
              totalCount: /\d/,
            }
          )
        end
      end
    end
  end
end
