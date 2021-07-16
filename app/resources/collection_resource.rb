class CollectionResource < JSONAPI::Resource
  attributes :name, :slug

  filter :slug

  has_many :cards
end
