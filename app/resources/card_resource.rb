class CardResource < JSONAPI::Resource
  attributes :front, :back

  has_one :card_set
  has_one :collection
end
