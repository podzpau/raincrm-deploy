class DashboardController < ApplicationController
  def index
    @deals = policy_scope(Deal)
    @recent_deals = @deals.recent.limit(5)
    @deals_by_status = @deals.group(:status).count
    @closing_soon = @deals.closing_soon
    @overdue_deals = @deals.select(&:overdue?)
    @recent_messages = current_user.messages.recent.limit(10)
  end

  def figma_demo
    @deals = policy_scope(Deal)
    @recent_deals = @deals.recent.limit(6)
  end
  
  private
  
  def policy_scope(scope)
    if current_user.admin?
      scope.all
    elsif current_user.loan_officer?
      scope.where(loan_officer: current_user)
    else
      scope.none
    end
  end
end
