class AddBalanceToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :balance, :float, default: 0, null: false, scale: 2
  end
end
