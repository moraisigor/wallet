FactoryBot.define do
  factory :create_transfer_success_response, class: Hash do
    request {
      {
        "id": "bcf1a7a5-dfcd-4004-ad4e-822e2bb0e93d",
        "create": "2022-10-10T10:10:10.999Z",
        "amount": 100,
        "sender_document": "99999999911",
        "receiver_document": "99999999999"
      }
    }

    initialize_with { attributes[:request] }
  end
end
