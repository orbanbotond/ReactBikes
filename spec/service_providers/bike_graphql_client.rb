# frozen_string_literal: true

require "httparty"

class BikeGraphqlClient
  include HTTParty
  base_uri "http://localhost:3000/graphql"

  def initialize(session_token)
    @session_token = session_token
  end

  def get_available_bikes
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def get_bike_models
    gql = <<~GQL
    {
      bikeModels{
        id,
        text
      }
    }
    GQL

    call_graphql(gql)
  end

  def get_users_with_reservations
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def get_users_with_pagination_info
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def get_bikes_with_reservations_and_models
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def get_bikes_with_pagination_info
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def create_reservation
    gql = <<~GQL
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

    variables = {
      "bikeId": GraphQL::Schema::UniqueWithinType.encode("Bike", 1),
      "startDate": "2041-10-22",
      "endDate": "2041-10-25"
    }

    call_graphql(gql, variables)
  end

  def update_reservation
    gql = <<~GQL
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

    variables = {
      "reservationId": GraphQL::Schema::UniqueWithinType.encode("Reservation", 1),
      "rating": 2
    }

    call_graphql(gql, variables)
  end

  def create_bike
    gql = <<~GQL
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

    variables = {
      "color": "red",
      "weight": 3.5,
      "bikeModelId": GraphQL::Schema::UniqueWithinType.encode("BikeModel", 1),
      "latitude": 23.15,
      "longitude": 35.38
    }

    call_graphql(gql, variables)
  end

  def delete_bike
    gql = <<~GQL
      mutation DeleteBike($bikeId: ID!){
        deleteBike(input: {bikeId: $bikeId}){
          errors
        }
      }
    GQL

    variables = {
      "bikeId": GraphQL::Schema::UniqueWithinType.encode("Bike", 1),
    }

    call_graphql(gql, variables)
  end

  def update_bike
    gql = <<~GQL
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

    variables = {
      "color": "blue",
      "weight": 4.5,
      "bikeId": GraphQL::Schema::UniqueWithinType.encode("Bike", 1),
    }

    call_graphql(gql, variables)
  end

  def update_user
    gql = <<~GQL
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

    variables = {
      "email": "another_email@gmail.com",
      "userId": GraphQL::Schema::UniqueWithinType.encode("User", -1)
    }

    call_graphql(gql, variables)
  end

  def create_user
    gql = <<~GQL
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

    variables = {
      "admin": false,
      "email": "a_totally_new_email@gmail.com",
      "password": "password"
    }

    call_graphql(gql, variables)
  end

  def delete_user
    gql = <<~GQL
      mutation DeleteUser($userId: ID!){
        deleteUser(input: {userId: $userId}){
          errors
        }
      }
    GQL

    variables = {
      "userId": GraphQL::Schema::UniqueWithinType.encode("User", -1),
    }

    call_graphql(gql, variables)
  end

private
  def call_graphql(gql, variables = {})
    httpartyy.post("/graphql",
      headers: { "X-Auth-Token" => @session_token, "Content-Type" => "application/json" },
      body: payload(gql, variables).to_json)
  end

  def httpartyy
    self.class
  end

  def payload(gql, variables = nil)
    {
      query: gql,
      variables: variables
    }
  end
end
