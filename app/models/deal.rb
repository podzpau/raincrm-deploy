class Deal < ApplicationRecord
  belongs_to :contact
  belongs_to :loan_officer, class_name: 'User'
  has_many :documents, dependent: :destroy
  has_many :messages, dependent: :destroy

  STATUS_OPTIONS = {
    'lead' => 'Lead',
    'contact_made' => 'Contact Made',
    'diagnostics' => 'Seller Diagnostics',
    'online_application' => 'Online Application',
    'credit_check' => 'Credit Check',
    'initial_docs' => 'Initial Documents',
    'income_verification' => 'Income Verification',
    'pre_approval' => 'Pre-Approval',
    'under_contract' => 'Under Contract',
    'processing' => 'Processing',
    'underwriting' => 'Underwriting',
    'final_docs' => 'Final Documents',
    'closing' => 'Closing',
    'closed' => 'Closed'
  }.freeze

  validates :title, :deal_type, :status, presence: true
  validates :deal_type, inclusion: { in: %w[purchase refinance] }
  validates :status, inclusion: { 
    in: %w[lead contact_made diagnostics online_application credit_check 
           initial_docs income_verification pre_approval under_contract 
           processing underwriting final_docs closing closed] 
  }
  validates :purchase_price, :loan_amount, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where.not(status: 'closed') }
  scope :by_status, ->(status) { where(status: status) }
  scope :closing_soon, -> { where(estimated_close_date: Date.current..1.week.from_now) }
  scope :recent, -> { order(updated_at: :desc) }

  def status_percentage
    case status
    when 'lead' then 5
    when 'contact_made' then 10
    when 'diagnostics' then 20
    when 'online_application' then 30
    when 'credit_check' then 40
    when 'initial_docs' then 50
    when 'income_verification' then 55
    when 'pre_approval' then 60
    when 'under_contract' then 70
    when 'processing' then 80
    when 'underwriting' then 85
    when 'final_docs' then 90
    when 'closing' then 95
    when 'closed' then 100
    else 0
    end
  end

  def overdue?
    estimated_close_date && estimated_close_date < Date.current
  end

  def days_until_close
    return nil unless estimated_close_date
    (estimated_close_date - Date.current).to_i
  end
end
