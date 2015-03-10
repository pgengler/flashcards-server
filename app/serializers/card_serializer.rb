class CardSerializer < ActiveModel::Serializer
	embed :ids, include: true
	attributes :id, :front, :back
	has_many :card_sets
end
