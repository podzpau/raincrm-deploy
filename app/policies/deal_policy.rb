class DealPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.admin? || record.loan_officer == user
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || record.loan_officer == user
  end

  def destroy?
    user.admin?
  end

  def update_status?
    update?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.loan_officer?
        scope.where(loan_officer: user)
      else
        scope.none
      end
    end
  end
end
