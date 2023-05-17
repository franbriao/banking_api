Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :accounts, only: [:create]

        get 'balance', to: 'accounts#balance'
        post 'withdraw', to: 'account_transactions#withdraw'
        post 'deposit', to: 'account_transactions#deposit'
      end
    end
  end
end
