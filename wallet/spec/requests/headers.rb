FactoryBot.define do
  factory :header, class: hash do
    header do
      { "accept": "application/json", "content-type": "application/json" }
    end
  end
end
