class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.timestamps
      t.string :kind, null: false
      t.integer :amount, null: false
      t.references :account, null: false, type: :uuid
    end
  end
end
