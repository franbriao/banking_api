require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  it { is_expected.to belong_to(:account) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_numericality_of(:value) }
  it { is_expected.to validate_presence_of(:transaction_type) }

  it 'has a valid factory' do
    expect(build(:account_transaction)).to be_valid
  end

  describe 'on credit transaction creation' do
    before(:all) do
      @account = create(:account, email: 'transaction1@testing.com')
      @current_balance = @account.balance
      @account_transaction = create(:account_transaction, account: @account,
                                                          value: 50.00, transaction_type: 'credit')
    end

    context 'when transaction is valid' do
      it 'is valid transaction' do
        expect(@account_transaction).to be_valid
      end

      it 'updated accounts balance' do
        expect(@account.balance).to be > @current_balance
      end
    end
  end

  describe 'on debit transaction creation' do
    before(:all) do
      @account = create(:account, email: 'transaction2@testing.com', balance: 500)
      @current_balance = @account.balance
      @account_transaction = create(:account_transaction, account: @account,
                                                          value: 50.00, transaction_type: 'debit')
    end

    context 'when transaction is valid' do
      it 'is valid transaction' do
        expect(@account_transaction).to be_valid
      end

      it 'updated accounts balance' do
        expect(@account.balance).to be < @current_balance 
      end
    end

    context 'when there is not enought balance' do
      let(:transaction) { build(:account_transaction, account: @account, value: 1000, transaction_type: 'debit') }

      it 'is not valid' do
        expect(transaction).not_to be_valid
      end
    end
  end
end
