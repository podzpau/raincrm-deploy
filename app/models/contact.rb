class Contact < ApplicationRecord
  belongs_to :user
  has_many :deals, dependent: :destroy

  attr_encrypted :email, :phone, key: :encryption_key
  attr_encrypted :address, :notes, key: :encryption_key

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :contact_type, inclusion: { in: %w[lead buyer seller borrower co_borrower] }

  scope :leads, -> { where(contact_type: 'lead') }
  scope :active, -> { where(active: true) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def lead?
    contact_type == 'lead'
  end

  private

  def encryption_key
    Rails.application.config.x.contact_encryption_key
  end
end
