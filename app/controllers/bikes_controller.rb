# frozen_string_literal: true

class BikesController < ApplicationController
  layout 'server-side-rendered-ui'

  protect_from_forgery except: :update
  before_action :bike, only: [:destroy, :edit, :show]

  def index
    @bikes = Bike.all.includes(:bike_model)
  end

  def destroy
    bike.destroy
    redirect_to bikes_path
  end

  def update
    picture = params[:bike][:picture]

    respond_to do |format|
      if bike.update(bike_params)

        if picture.present?
          bike.picture.attach(picture)
        end
        format.html { redirect_to bikes_path, notice: "Bike was successfully updated." }
        format.json { render json: Entities::BikeEntity.new(bike).as_json }
      else
        format.html { render :edit }
        format.json { render json: bike.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  private
    def bike
      @bike ||= Bike.find params[:id]
    end

    def bike_params
      params.require(:bike).permit(:picture, :weight, :color, :latitude, :longitude, :bike_model_id)
    end
end
