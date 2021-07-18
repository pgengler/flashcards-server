class CardSetResource < JSONAPI::Resource
  attributes :name

  has_many :cards
  has_one :collection
end
