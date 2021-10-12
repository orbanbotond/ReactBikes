# frozen_string_literal: true

require "graphql/rake_task"
GraphQL::RakeTask.new(schema_name: "ToptalReactBikesSchema")

# usage: rake graphql:schema:dump
