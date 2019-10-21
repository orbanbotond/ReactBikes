# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Trailblazer::Rails::Controller

  protect_from_forgery with: :exception
end
