class Api::V1::AccountTransactionsController < ApplicationController
  before_action :authenticate

  def withdraw
    transaction = @account.account_transactions.new(post_params.merge(transaction_type: 'debit'))
    if transaction.save
      render json: { message: 'Value withdrawn successfully' }, status: :created
    else
      render json: { errors: transaction.errors }, status: :unprocessable_entity
    end
  end

  def deposit
    transaction = @account.account_transactions.new(post_params.merge(transaction_type: 'credit'))
    if transaction.save
      render json: { message: 'Value deposited successfully' }, status: :created
    else
      render json: { errors: transaction.errors }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:account_transaction).permit(:value)
  end
end
