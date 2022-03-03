class Transaction < ApplicationRecord
  belongs_to :account

  validates :kind, presence: true
  validates :amount, presence: true
  validates :account, presence: true

  def is_debit?
    self.kind.to_sym == :debit
  end

  def is_credit?
    self.kind.to_sym == :credit
  end
end
