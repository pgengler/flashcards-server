FactoryBot.define do
  sequence :card_set_name do |n|
    "Card Set #{n}"
  end

  factory :card_set do
    name { generate(:card_set_name) }
    collection
  end
end
