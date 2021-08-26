# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  mount Bikes::API => "/"

  BLACKLIST = ["/api/swagger", "/rails", "/graphql"]
  get "*path", to: "home#index", constraints: lambda {|req| BLACKLIST.none?{|x| req.env["REQUEST_PATH"].starts_with? x } }
end
