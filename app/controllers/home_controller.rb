# frozen_string_literal: true

class HomeController < ApplicationController
  def classic
  end

  def index
    gon.available_colors = Bike::COLORS
    @use_react = true
  end
end
