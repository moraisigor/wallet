class CreateAccount < ActiveRecord::Migration[7.0]
  def change
    enable_extension "pgcrypto"

    create_table :accounts, id: :uuid do |t|
      t.timestamps
      t.string :name, null: false
      t.string :document, null: false, index: { unique: true }
    end
  end
end
