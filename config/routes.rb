# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bikes, path: "bycicles", only: [:update, :show, :edit]
  root to: "home#index"

  namespace :api, constraints: { format: 'json' }, defaults: {format: :json} do
    get 'ping', to: 'ping#ping'
    post 'login', to: 'login#create'
  end

  mount Bikes::API => "/"

  BLACKLIST = ["/api/swagger", "/rails"]
  get "*path", to: "home#index", constraints: lambda {|req| BLACKLIST.none?{|x| req.env["REQUEST_PATH"].starts_with? x } }
end
