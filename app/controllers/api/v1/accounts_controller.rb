class Api::V1::AccountsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :authenticate, only: [:balance]

  def create
    account = Account.new(post_params)
    if account.save
      render json: { api_key: account.api_key }, status: :created
    else
      render json: { errors: account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def balance
    render json: { current_balance: number_to_currency(@account.balance, precision: 2, format: '%n') },
           status: :ok
  end

  private

  def post_params
    params.require(:account).permit(:email)
  end
end
