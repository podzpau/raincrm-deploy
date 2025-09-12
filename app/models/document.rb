class Document < ApplicationRecord
  belongs_to :deal
  belongs_to :user

  include Shrine::Attachment(:file)

  attr_encrypted :encrypted_file_data, key: :encryption_key

  validates :filename, :file_type, presence: true
  validates :file_type, inclusion: { 
    in: %w[bank_statement income_verification tax_return credit_report 
           purchase_agreement appraisal title_document other] 
  }

  scope :by_type, ->(type) { where(file_type: type) }
  scope :recent, -> { order(upload_date: :desc) }

  def sensitive?
    %w[bank_statement income_verification tax_return credit_report].include?(file_type)
  end

  private

  def encryption_key
    Rails.application.config.x.document_encryption_key
  end
end
