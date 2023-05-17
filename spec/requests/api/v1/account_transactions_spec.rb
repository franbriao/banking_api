require 'rails_helper'

RSpec.describe 'Api::V1::AccountTransactions', type: :request do
  let!(:new_account) { create(:account, email: 'transactions_requests@testing.com', balance: 100) }
  let!(:initial_balance) { new_account.balance }

  describe 'POST /api/v1/withdraw' do
    context 'when not authenticated' do
      it 'returns unauthorized and Inform valid API Key on X-Api-Key header message' do
        post '/api/v1/withdraw', params: { account_transaction: { value: 50 } }
        expect(response).to have_http_status :unauthorized
        expect(response.body).to include 'Inform valid API Key on X-Api-Key header'
      end
    end

    context 'when authenticated' do
      it 'returns created and changes the accounts balance' do
        post '/api/v1/withdraw', params: { account_transaction: { value: 50 } }, headers: { 'X-Api-Key': new_account.api_key }
        expect(response).to have_http_status :created
        expect(Account.find_by(api_key: new_account.api_key).balance).to be < initial_balance
      end

      it 'returns unprocessable_entity if there isnt enought balance' do
        post '/api/v1/withdraw', params: { account_transaction: { value: 500 } }, headers: { 'X-Api-Key': new_account.api_key }
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include 'Not enough balance to withdraw value'
      end
    end
  end

  describe 'POST /api/v1/deposit' do
    context 'when not authenticated' do
      it 'returns unauthorized and Inform valid API Key on X-Api-Key header message' do
        post '/api/v1/deposit', params: { account_transaction: { value: 50 } }
        expect(response).to have_http_status :unauthorized
        expect(response.body).to include 'Inform valid API Key on X-Api-Key header'
      end
    end

    context 'when authenticated' do
      it 'returns created and changes the accounts balance' do
        post '/api/v1/deposit', params: { account_transaction: { value: 500 } }, headers: { 'X-Api-Key': new_account.api_key }
        expect(response).to have_http_status :created
        expect(Account.find_by(api_key: new_account.api_key).balance).to be > initial_balance
      end
    end
  end
end
