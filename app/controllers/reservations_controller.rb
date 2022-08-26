# frozen_string_literal: true

class ReservationsController < ApplicationController
  layout 'server-side-rendered-ui'

  protect_from_forgery except: :update

  def index
    reservations = Reservation.all
    @reservations = reservations.where(bike_id: reservation_params[:bike_id]) if reservation_params[:bike_id].present?
    @reservations = reservations.where(user_id: reservation_params[:user_id]) if reservation_params[:user_id].present?
  end

  private

    def reservation_params
      params.permit(:bike_id, :user_id)
    end
end
