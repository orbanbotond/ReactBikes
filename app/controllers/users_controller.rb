# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'server-side-rendered-ui'

  protect_from_forgery except: :update

  def index
    @users = User.all
  end
end
