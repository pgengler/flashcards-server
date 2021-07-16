FactoryBot.define do
  sequence :collection_name do |n|
    "Collection #{n}"
  end

  factory :collection do
    name { generate(:collection_name) }
  end
end
