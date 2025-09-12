class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :deals_as_loan_officer, class_name: 'Deal', foreign_key: 'loan_officer_id', dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :role, inclusion: { in: %w[admin loan_officer processor underwriter] }

  scope :loan_officers, -> { where(role: 'loan_officer') }
  scope :active, -> { where(active: true) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'admin'
  end

  def loan_officer?
    role == 'loan_officer'
  end
end
