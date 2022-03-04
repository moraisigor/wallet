class CreateTransfer < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers, id: :uuid do |t|
      t.timestamps
      t.references :transaction_send, null: false, type: :uuid, foreign_key: { to_table: :transactions }
      t.references :transaction_receive, null: false, type: :uuid, foreign_key: { to_table: :transactions }
      t.references :account, null: false, type: :uuid
    end
  end
end
