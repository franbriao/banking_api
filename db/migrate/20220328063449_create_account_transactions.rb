class CreateAccountTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :account_transactions do |t|
      t.references :account, foreign_key: true, index: true
      t.integer :transaction_type, null: false
      t.float :value, scale: 2, null: false
      t.timestamps
    end
  end
end
