class AccountTransaction < ApplicationRecord
  enum transaction_type: { debit: 0, credit: 1 }

  belongs_to :account

  validates :value, presence: true, format: { with: /\A\d[0-9]*(\.\d{1,2})?\z/,
                                              message: 'accepts 2 decimal numbers only' }
  validates_numericality_of :value
  validates :transaction_type, presence: true
  validate :account_balance, if: :withdraw?

  after_save :update_account_balance

  def withdraw?
    transaction_type == 'debit'
  end

  private

  def account_balance
    errors.add(:not_enough_balance, 'Not enough balance to withdraw value') if account.balance < value
  end

  def update_account_balance
    updated_balance = transaction_type == 'debit' ? account.balance - value : account.balance + value
    account.update!(balance: updated_balance)
  end
end
