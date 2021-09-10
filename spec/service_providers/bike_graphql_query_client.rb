require 'httparty'

class BikeGraphqlQueryClient
  include HTTParty
  base_uri 'http://localhost:3000/graphql'

  def get_bikes
    gql = <<~GQL
      {
        bikes{
          id
        }
      }
    GQL

    httpartyy.post("/graphql", 
      headers: { 'Content-Type' => 'application/json' },
      body: payload(gql).to_json)
  end

private
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