class UserTypePolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def visible?(required_role)
    @current_user.send(required_role)
  end
end