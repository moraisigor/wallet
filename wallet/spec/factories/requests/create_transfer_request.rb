FactoryBot.define do
  factory :create_transfer_request, class: Hash do
    request { { "amount": 100, "sender_document": "99999999911", "receiver_document": "99999999999" } }

    initialize_with { attributes[:request] }
  end
end
