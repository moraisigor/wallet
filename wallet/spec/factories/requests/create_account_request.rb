FactoryBot.define do
  factory :create_account_request, class: Hash do
    name { "igor" }
    document { "99999999999" }
    amount { 1000 }

    initialize_with { attributes }
  end
end
