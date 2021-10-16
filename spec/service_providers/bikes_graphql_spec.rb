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
    describe "reservations" do
      context "when updating it" do
        let(:variables) do
          {
            "reservationId": GraphQL::Schema::UniqueWithinType.encode("Reservation", 1),
            "rating": 2
          }
        end

        let(:gql) do
          <<~GQL
            mutation UpdateReservation($cancelled: Boolean, $rating: Int, $reservationId: ID!){
              updateReservation(input:{ cancelled: $cancelled,
                                        rating: $rating,
                                        reservationId: $reservationId} ){
                reservation{
                  id,
                },
                errors,
              }
            }
          GQL
        end
        let(:provider_state) { "a user with reservation exists" }
        let(:message_description) { "a request for reservation update" }
        let(:mocked_body_content) do
          {
            data: {
              updateReservation: {
                reservation: {
                  id: Pact.like("1"),
                },
                errors: []
              }
            }
          }
        end

        it "returns a reservation" do
          expect(JSON.parse(subject.update_reservation.body, { symbolize_names: true })[:data]).to include_json(
            updateReservation: {
              reservation: {
                id: /\d/,
              },
              errors: []
            }
          )
        end
      end

      context "when creating it" do
        let(:variables) do
          {
            "bikeId": GraphQL::Schema::UniqueWithinType.encode("Bike", 1),
            "startDate": "2041-10-22",
            "endDate": "2041-10-25"
          }
        end

        let(:gql) do
          <<~GQL
            mutation CreateReservation($startDate: ISO8601Date!, $endDate: ISO8601Date!, $bikeId: ID!){
              createReservation(input:{ startDate: $startDate,
                                        endDate: $endDate,
                                        bikeId: $bikeId} ){
                reservation {
                  id,
                },
                errors,
              }
            }
          GQL
        end
        let(:provider_state) { "a bike exists" }
        let(:message_description) { "a request for reservation creation" }
        let(:mocked_body_content) do
          {
            data: {
              createReservation: {
                reservation: {
                  id: Pact.like("1"),
                },
                errors: []
              }
            }
          }
        end

        it "returns a reservation" do
          expect(JSON.parse(subject.create_reservation.body, { symbolize_names: true })[:data]).to include_json(
            createReservation: {
              reservation: {
                id: /\d/,
              },
              errors: []
            }
          )
        end
      end
    end

    describe "users" do
      context "when deleting it" do
        let(:variables) do
          {
            "userId": GraphQL::Schema::UniqueWithinType.encode("User", -1)
          }
        end

        let(:gql) do
          <<~GQL
            mutation DeleteUser($userId: ID!){
              deleteUser(input: {userId: $userId}){
                errors
              }
            }
          GQL
        end
        let(:provider_state) { "a user exists" }
        let(:message_description) { "a request for user delete" }
        let(:mocked_body_content) do
          {
            data: {
              deleteUser: {
                errors: []
              }
            }
          }
        end

        it "returns the empty errors array" do
          expect(JSON.parse(subject.delete_user.body, { symbolize_names: true })[:data]).to include_json(
            deleteUser: {
              errors: []
            }
          )
        end
      end

      context "when updating them" do
        let(:variables) do
          {
            "email": "another_email@gmail.com",
            "userId": GraphQL::Schema::UniqueWithinType.encode("User", -1)
          }
        end

        let(:gql) do
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
        let(:provider_state) { "a user exists" }
        let(:message_description) { "a request for user update" }
        let(:mocked_body_content) do
          {
            data: {
              updateUser: {
                user: {
                  id: Pact.like("1")
                },
                errors: []
              }
            }
          }
        end

        it "returns the updated user" do
          expect(JSON.parse(subject.update_user.body, { symbolize_names: true })[:data]).to include_json(
            updateUser: {
              user: {
                id: /\d/,
              },
              errors: []
            }
          )
        end
      end

      context "when creating them" do
        let(:variables) do
          {
            "admin": false,
            "email": "a_totally_new_email@gmail.com",
            "password": "password"
          }
        end

        let(:gql) do
          <<~GQL
            mutation createUser($email: String!, $admin: Boolean!, $password: String!){
              createUser(input: {email: $email,
                                 admin: $admin,
                                 password: $password}){
                user {
                  id,
                },
                errors,
              }
            }
          GQL
        end
        let(:provider_state) { "a user exists" }
        let(:message_description) { "a request for user creation" }
        let(:mocked_body_content) do
          {
            data: {
              createUser: {
                user: {
                  id: Pact.like("1"),
                },
                errors: []
              }
            }
          }
        end

        it "returns a user" do
          expect(JSON.parse(subject.create_user.body, { symbolize_names: true })[:data]).to include_json(
            createUser: {
              user: {
                id: /\d/,
              },
              errors: []
            }
          )
        end
      end
    end

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

      context "when deleting it" do
        let(:variables) do
          {
            "bikeId": GraphQL::Schema::UniqueWithinType.encode("Bike", 1)
          }
        end

        let(:gql) do
          <<~GQL
            mutation DeleteBike($bikeId: ID!){
              deleteBike(input: {bikeId: $bikeId}){
                errors
              }
            }
          GQL
        end
        let(:provider_state) { "a bike exists" }
        let(:message_description) { "a request for bike delete" }
        let(:mocked_body_content) do
          {
            data: {
              deleteBike: {
                errors: []
              }
            }
          }
        end

        it "returns the empty errors array" do
          expect(JSON.parse(subject.delete_bike.body, { symbolize_names: true })[:data]).to include_json(
            deleteBike: {
              errors: []
            }
          )
        end
      end
    end
  end

  describe "queries" do
    describe "get bike models" do
      let(:gql) do
        <<~GQL
        {
          bikeModels{
            id,
            text
          }
        }
        GQL
      end
      let(:provider_state) { "a bike model exists" }
      let(:message_description) { "a request for bike models" }
      let(:mocked_body_content) do
        {
          data: {
            bikeModels: [{
              id: Pact.like("1"),
              text: Pact.like("Mountain"),
            }]
          }
        }
      end

      it "returns bike models" do
        expect(JSON.parse(subject.get_bike_models.body, { symbolize_names: true })[:data]).to include_json(
          bikeModels: UnorderedArray({
              id: /\d*/,
              text: /.*/,
          })
        )
      end
    end

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

    describe "get available bikes" do
      let(:gql) do
        <<~GQL
          query AvailableBikes{
            availableBikes(startDate: "2021-10-22", endDate:"2021-10-25"){
              nodes{
                id,
                averageRating,
                latitude,
                longitude,
                weight,
                color,
                model{
                  id
                },
                imageUrl
              }
            }
          }
        GQL
      end
      let(:provider_state) { "a bike exists" }
      let(:message_description) { "a request for available bikes" }
      let(:mocked_body_content) do
        {
          data: {
            availableBikes: {
              nodes: [{
                  id: Pact.like("1"),
                  averageRating: Pact.like(1.2),
                  latitude: Pact.like(1.2),
                  longitude: Pact.like(1.2),
                  weight: Pact.like(1.2),
                  model: {
                    id: Pact.like("Mountain")
                  },
                  imageUrl: nil
              }]
            }
          }
        }
      end

      it "returns bikes" do
        expect(JSON.parse(subject.get_available_bikes.body, { symbolize_names: true })[:data]).to include_json(
          availableBikes: {
            nodes: UnorderedArray({
              id: /\d/,
              averageRating: /\.*/,
              latitude: /\.*/,
              longitude: /\.*/,
              weight: /\.*/,
              imageUrl: /\.*/,
              model: {
                id: /\.*/
              }
            })
          }
        )
      end
    end
  end
end
