class Message < ApplicationRecord
  belongs_to :user
  belongs_to :deal

  validates :content, presence: true
  validates :message_type, inclusion: { in: %w[note status_update system_message chat] }

  scope :unread, -> { where(read_at: nil) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_type, ->(type) { where(message_type: type) }

  def read?
    read_at.present?
  end

  def mark_as_read!
    update(read_at: Time.current) unless read?
  end

  def system_message?
    message_type == 'system_message'
  end

  def status_update?
    message_type == 'status_update'
  end
end
