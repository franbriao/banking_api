class Account < ApplicationRecord
  has_many :account_transactions

  validates_email_format_of :email, message: 'not valid'
  validates :email, presence: true, uniqueness: true

  before_create :set_api_key

  def set_api_key
    self.api_key = generate_api_key
  end

  # Did this for testing
  def calculate_balance
    (account_transactions.credit.sum(:value) - account_transactions.debit.sum(:value))
  end

  private

  def generate_api_key
    SecureRandom.base58(24)
  end
end
