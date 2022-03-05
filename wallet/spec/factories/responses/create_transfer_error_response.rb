FactoryBot.define do
  factory :create_transfer_error_response, class: Hash do

    trait :account_not_found_error do
      error { { "code": "account_not_found_error", "message": "account not found" } }
    end

    trait :insufficient_balance_error do
      error { { "code": "insufficient_balance_error", "message": "the account does not have enough balance" } }
    end

    trait :duplicate_transaction_error do
      error { { "code": "duplicate_transaction_error", "message": "the transaction is duplicated" } }
    end

    trait :server_error do
      error { { "code": "server_error", "message": "the server had an unexpected error" } }
    end

    initialize_with { attributes[:error] }
  end
end
