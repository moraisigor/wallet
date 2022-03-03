class Transfer < ApplicationRecord
  belongs_to :transaction_send, :class_name => "Transaction"
  belongs_to :transaction_receive, :class_name => "Transaction"
  belongs_to :account

  validates :transaction_send, presence: true
  validates :transaction_receive, presence: true
  validates :account, presence: true
end
