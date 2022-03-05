FactoryBot.define do
  factory :create_account_error_response, class: Hash do
    code { "create_account_error" }
    message { "the account has already been created" }

    initialize_with { attributes }
  end
end
