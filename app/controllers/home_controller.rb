class HomeController < ApplicationController
  def index
    gon.available_colors = Bike::COLORS
  end
end
