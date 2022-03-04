FactoryBot.define do
  factory :create_account_request, class: Hash do
    {
      "name": "igor",
      "document": "9999999999",
      "amount": 1000
    }
  end
end
