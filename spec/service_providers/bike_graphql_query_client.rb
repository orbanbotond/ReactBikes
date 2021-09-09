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

    payload = {
      query: gql,
      variables: nil
    }

    self.class.post("/graphql", 
      headers: { 'Content-Type' => 'application/json' },
      body: payload.to_json)
  end
end