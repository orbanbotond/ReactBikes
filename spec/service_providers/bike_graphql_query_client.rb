require 'httparty'

class BikeGraphqlQueryClient
  include HTTParty
  base_uri 'http://localhost:3000/graphql'

  def initialize(session_token)
    @session_token = session_token
  end

  def get_bikes_with_reservations_and_models
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def get_bikes_with_pagination_info
    gql = <<~GQL
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

    call_graphql(gql)
  end


private
  def call_graphql(gql)
    httpartyy.post("/graphql",
      headers: { "X-Auth-Token" => @session_token, 'Content-Type' => 'application/json' },
      body: payload(gql).to_json)
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