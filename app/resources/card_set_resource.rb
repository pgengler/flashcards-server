class CardSetResource < JSONAPI::Resource
  attributes :name

  has_many :cards
end
