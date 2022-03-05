FactoryBot.define do
  factory :header, class: Hash do
    header { { "accept": "application/json", "content-type": "application/json" } }

    initialize_with { attributes[:header] }
  end
end
