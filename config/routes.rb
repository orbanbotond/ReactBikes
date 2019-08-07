# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bikes, path: "bycicles", only: [:update, :show, :edit]
  root to: "home#index"

  mount Bikes::API => "/"

  namespace :api, constraints: { format: 'json' }, defaults: {format: :json} do
    namespace :v2 do
      get 'ping', to: 'ping#ping'
    end
  end


  BLACKLIST = ["/api/swagger", "/rails"]
  get "*path", to: "home#index", constraints: lambda {|req| BLACKLIST.none?{|x| req.env["REQUEST_PATH"].starts_with? x } }
end
