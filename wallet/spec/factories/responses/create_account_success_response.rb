FactoryBot.define do
  factory :create_account_success_response, class: Hash do
    id { "2a152f18-1aab-49d4-ade7-e15569bfeb22" }
    name { "igor" }
    document { "99999999999" }
    amount { 1000 }

    initialize_with { attributes }
  end
end
