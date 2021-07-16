class CollectionResource < JSONAPI::Resource
  attributes :name

  filter :slug

  has_many :cards
end
