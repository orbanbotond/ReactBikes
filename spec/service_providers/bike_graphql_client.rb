require 'httparty'

class BikeGraphqlClient
  include HTTParty
  base_uri 'http://localhost:3000/graphql'

  def initialize(session_token)
    @session_token = session_token
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

  def create_bike
    gql = <<~GQL
      mutation createBikes($color: BikeColorsEnum!, $weight: Float!, $latitude: Float!, $longitude: Float!, $bikeModelId: Int!){
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
      "bikeModelId": 1,
      "latitude": 23.15,
      "longitude": 35.38
    }


    call_graphql(gql, variables)
  end


private
  def call_graphql(gql, variables={})
    httpartyy.post("/graphql",
      headers: { "X-Auth-Token" => @session_token, 'Content-Type' => 'application/json' },
      body: payload(gql, variables).to_json)
  end

  def httpartyy
    self.class
  end

  def payload(gql, variables=nil)
    {
      query: gql,
      variables: variables
    }
  end
end