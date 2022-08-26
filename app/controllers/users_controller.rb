# frozen_string_literal: true

class UsersController < ApplicationController
  layout 'server-side-rendered-ui'

  protect_from_forgery except: :update
  before_action :user, only: [:edit, :update, :destroy]
  before_action :users, only: :index

  def index
  end

  def destroy
    user.destroy
    redirect_to users_path
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create user_params
    if @user.valid?
      redirect_to users_path
    else
      render edit_user_path(@user)
    end
  end

  def update
    @user.update user_params
    if @user.valid?
      redirect_to users_path
    else
      render edit_user_path(@user)
    end
  end

private

  def user
    @user ||= User.find params[:id]
  end

  def users
    @users = User.all
  end

  def user_params
    params.require(:user).permit(:admin, :email, :password)
  end
end
