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
end