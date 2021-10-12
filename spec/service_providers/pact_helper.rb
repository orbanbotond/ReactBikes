# frozen_string_literal: true

require "pry-byebug"
require "pact/consumer/rspec"

Pact.service_consumer "Bikes UI" do
  has_pact_with "Bikes GraphQL Query" do
    mock_service :bikes_graphql_query do
      port 1234
    end
  end
end
