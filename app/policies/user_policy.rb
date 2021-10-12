# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def field_visible_by?(required_role, field)
    case field.to_sym
    when :admin
      @current_user.send(required_role)
    end
  end
end
