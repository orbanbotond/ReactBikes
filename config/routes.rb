# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "home#index"

  mount Bikes::API => "/"

  get "*path", to: "home#index", constraints: lambda { |req| req.env["REQUEST_PATH"] != "/api/swagger" }
end
