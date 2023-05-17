FactoryBot.define do
  factory :account_transaction do
    account { create(:account, email: 'transactions@testing.com') }
    value { 50.00 }
    transaction_type { 'credit' }
  end
end
