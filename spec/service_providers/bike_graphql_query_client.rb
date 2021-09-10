require 'httparty'

class BikeGraphqlQueryClient
  include HTTParty
  base_uri 'http://localhost:3000/graphql'

  def get_bikes_with_reservations
    gql = <<~GQL
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

    call_graphql(gql)
  end

  def get_bikes
    gql = <<~GQL
      {
        bikes{
          id
        }
      }
    GQL

    call_graphql(gql)
  end

private
  def call_graphql(gql)
    httpartyy.post("/graphql", 
      headers: { 'Content-Type' => 'application/json' },
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