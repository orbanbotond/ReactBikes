# frozen_string_literal: true

module Api
  class PingController < ActionController::Base

    def ping
      render :json => { ping: params[:pong] || "pong" }
    end
  end
end
