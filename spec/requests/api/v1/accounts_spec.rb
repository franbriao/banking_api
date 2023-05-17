require 'rails_helper'

RSpec.describe 'Api::V1::Accounts', type: :request do
  describe 'POST /api/v1/accounts' do
    context 'when has valid attributes' do
      it 'returns status created and api_key' do
        post '/api/v1/accounts', params: { account: { email: 'new_account@testing.com' } }
        expect(response).to have_http_status :created
        expect(response.body).to include 'api_key'
      end
    end

    context 'when does not have a valid email' do
      it 'returns unprocessable_entity' do
        post '/api/v1/accounts', params: { account: { email: '' } }
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'when tries to create account with existing email' do
      before do
        create(:account, email: 'account1@testing.com')
      end

      it 'returns unprocessable_entity and already been taken message' do
        post '/api/v1/accounts', params: { account: { email: 'account1@testing.com' } }
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include 'already been taken'
      end
    end
  end

  describe 'GET /api/v1/balance' do
    context 'when not authenticated' do
      it 'returns unauthorized and Inform valid API Key on X-Api-Key header message' do
        get '/api/v1/balance'
        expect(response).to have_http_status :unauthorized
        expect(response.body).to include 'Inform valid API Key on X-Api-Key header'
      end
    end

    context 'when authenticated' do
      let!(:new_account) { create(:account, email: 'authenticated@testing.com', balance: 50) }

      it 'returns unauthorized and Inform valid API Key on X-Api-Key header message' do
        get '/api/v1/balance', headers: { 'X-Api-Key': new_account.api_key }
        expect(response).to have_http_status :ok
        expect(response.body).to include 'current_balance'
      end
    end
  end
end
