FactoryBot.define do
  factory :get_transfer_account_success_response, class: Hash do
    id { "bcf1a7a5-dfcd-4004-ad4e-822e2bb0e93d" }
    create { "2022-10-10T10:10:10.999Z" }
    transaction_send { { id: "ecc6c3d7-9c70-4c8d-952f-248b35b16ad4", kind: "debit", amount: 100 } }
    transaction_receive { { id: "89d21bf1-498b-4790-be2f-a5adac37f13a", kind: "credit", amount: 100 } }
    account { { id: "ecc6c3d7-9c70-4c8d-952f-248b35b16ad4", name: "igor", document: "99999999999" } }

    initialize_with { attributes }
  end
end
