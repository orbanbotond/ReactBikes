# frozen_string_literal: true

module Api
  module V2
    class PingController < ActionController::Base
      protect_from_forgery with: :exception

      def ping
        render :json => { ping: params[:pong] || "pong" }
      end
    end
  end
end

