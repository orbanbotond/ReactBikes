# frozen_string_literal: true

class BikesController < ApplicationController
  protect_from_forgery except: :update

  def update
    picture = params[:bike][:picture]

    respond_to do |format|
      if bike.update(bike_params)

        if picture.present?
          bike.picture.attach(picture)
        end
        format.html { redirect_to bike, notice: "Bike was successfully updated." }
        format.json { render json: Entities::BikeEntity.new(bike).as_json }
      else
        format.html { render :edit }
        format.json { render json: bike.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    bike
  end

  def show
    bike
  end

  private
    def bike
      @bike ||= Bike.find params[:id]
    end

    def bike_params
      params.require(:bike).permit(:picture)
    end
end
