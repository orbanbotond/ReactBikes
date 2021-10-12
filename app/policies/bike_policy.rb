# frozen_string_literal: true

class BikePolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def create?
    current_user.admin?
  end
end
