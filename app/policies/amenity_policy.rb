class AmenityPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.partner?
  end

  def update?
    user.partner? || user.admin?
  end

  def destroy?
    user.partner? || user.admin?
  end
end
