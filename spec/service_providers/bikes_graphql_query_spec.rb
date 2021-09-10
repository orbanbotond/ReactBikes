require_relative './pact_helper'
require_relative './bike_graphql_query_client'
require "rspec/json_expectations"

describe BikeGraphqlQueryClient, :pact => true do
  before do
    # Configure your client to point to the stub service on localhost using the port you have specified
    BikeGraphqlQueryClient.base_uri 'localhost:1234'
  end

  subject { BikeGraphqlQueryClient.new }

  let!(:initialization) do
    bikes_graphql_query.given(provider_state).
      upon_receiving(message_description).
      with(method: :post, 
           path: '/graphql', 
           body: payload,
           headers: { 'Content-Type' => 'application/json' }).
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
    context "when querying just the bikes" do
      let(:gql) do
        <<~GQL
          {
            bikes{
              id
            }
          }
        GQL
      end
      let(:provider_state){"a bike exists"}
      let(:message_description){"a request for bikes"}
      let(:mocked_body_content) do
        {
          "data": {
            bikes: [ {id: Pact.like("1")} ]
          }
        }
      end

      it "returns bikes" do
        expect(JSON.parse(subject.get_bikes.body, {:symbolize_names => true})[:data]).to include_json(
          bikes: UnorderedArray(
            { id: /\d/}
          )
        )
      end
    end

    context "when querying the bikes with their reservations" do
      let(:gql) do
        <<~GQL
          {
            bikes{
              id,
              reservations {
                cancelled,
                user {
                  email
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
          "data": {
            bikes: [{
              id: Pact.like("1"),
              reservations: [{
                cancelled: false,
                user: {
                  "email": Pact.like("boti@toptal.com")
                }
              }]
            }]
          }
        }
      end

      it "returns bikes" do
        expect(JSON.parse(subject.get_bikes_with_reservations.body, {:symbolize_names => true})[:data]).to include_json(
          bikes: UnorderedArray({ 
            id: /\d/,
            reservations: UnorderedArray({
              cancelled: false,
              user: {
                email: /\.*/
              }
            })
          })
        )
      end
    end

    context "when querying the bikes with their models" do
      let(:gql) do
        <<~GQL
          {
            bikes{
              id,
              model{
                text
              }
            }
          }
        GQL
      end
      let(:provider_state){"a bike exists"}
      let(:message_description){"a request for bikes with models"}
      let(:mocked_body_content) do
        {
          "data": {
            bikes: [{
                id: Pact.like("1"),
                model: {
                  text: Pact.like("Mountain"),
                }
            }]
          }
        }
      end

      it "returns bikes" do
        expect(JSON.parse(subject.get_bikes_with_models.body, {:symbolize_names => true})[:data]).to include_json(
          bikes: UnorderedArray({
            id: /\d/,
            model: {
              text: /\.*/
            }
          })
        )
      end
    end
  end
end