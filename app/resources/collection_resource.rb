class CollectionResource < JSONAPI::Resource
  attributes :name, :slug

  filter :slug

  has_many :cards
  has_many :card_sets
end
