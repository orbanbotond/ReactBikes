require_relative './pact_helper'
require_relative './bike_graphql_query_client'
require "rspec/json_expectations"

describe BikeGraphqlQueryClient, :pact => true do
  before do
    BikeGraphqlQueryClient.base_uri 'localhost:1234'
  end

  let(:session_token) { "token-xxx123123" }

  subject { BikeGraphqlQueryClient.new(session_token) }

  let!(:initialization) do
    bikes_graphql_query.given(provider_state).
      upon_receiving(message_description).
      with(method: :post, 
           path: '/graphql', 
           body: payload,
           headers: { "X-Auth-Token" => session_token, 'Content-Type' => 'application/json' }).
      will_respond_with(
        status: 200,
        headers: {'Content-Type' => 'application/json; charset=utf-8'},
        body: mocked_body_content
      )
  end

  let(:payload) do
    {
      "query" => gql,
      "variables" => nil
    }    
  end

  describe "get_bikes" do
    context "when querying the bikes with their reservations and models" do
      let(:gql) do
        <<~GQL
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
      end
      let(:provider_state){"a bike with reservation exists"}
      let(:message_description){"a request for bikes with reservations"}
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
        expect(JSON.parse(subject.get_bikes_with_reservations_and_models.body, {:symbolize_names => true})[:data]).to include_json(
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
                node {
                  id,
                }
                cursor
              },
              pageInfo {
                endCursor,
                hasNextPage,
                hasPreviousPage,
                startCursor
              },
              totalCount
            }
          }
        GQL
      end
      let(:provider_state){"a bike exists"}
      let(:message_description){"a request for bikes with reservations"}
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
              totalCount: Pact.like(1)
            }
          }
        }
      end

      it "returns bikes" do
        expect(JSON.parse(subject.get_bikes_with_pagination_info.body, {:symbolize_names => true})[:data]).to include_json(
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