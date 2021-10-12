# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require "pact/provider/rspec"
require File.expand_path("./provider_states_for_bike_graphql_query_consumer", __dir__)

Pact.service_provider "Bike Service" do
  honours_pact_with "Bikes GraphQL Query" do
    # This example points to a local file, however, on a real project with a continuous
    # integration box, you would use a [Pact Broker](https://github.com/pact-foundation/pact_broker) or publish your pacts as artifacts,
    # and point the pact_uri to the pact published by the last successful build.

    pact_uri File.expand_path("../pacts/bikes_ui-bikes_graphql_query.json", __dir__)
  end
end
