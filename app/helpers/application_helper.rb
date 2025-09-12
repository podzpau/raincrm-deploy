module ApplicationHelper
  def status_badge_classes(status)
    case status
    when 'lead'
      'bg-yellow-100 text-yellow-800'
    when 'pre_approval', 'under_contract'
      'bg-green-100 text-green-800'
    when 'processing', 'underwriting'
      'bg-blue-100 text-blue-800'
    when 'closed'
      'bg-gray-100 text-gray-700'
    else
      'bg-gray-100 text-gray-700'
    end
  end

  def deal_type_icon_classes(deal_type)
    case deal_type
    when 'purchase'
      'text-blue-600'
    when 'refinance'
      'text-green-600'
    else
      'text-gray-600'
    end
  end
end
