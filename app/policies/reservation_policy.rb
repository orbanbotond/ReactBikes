# frozen_string_literal: true

class ReservationPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      return scope if user.admin?

      owner = scope.proxy_association.owner
      return scope if owner.is_a?(User) && (owner == user)

      scope.none
    end

    private
      attr_reader :user, :scope
  end

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def update?
    current_user.admin? || model.user == current_user
  end
end
