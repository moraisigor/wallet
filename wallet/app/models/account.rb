class Account < ApplicationRecord
  has_many :transactions

  validates :name, presence: true
  validates :document, presence: true
end
