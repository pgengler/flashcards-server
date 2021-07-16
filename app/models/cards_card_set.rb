class CardSet < ApplicationRecord
	belongs_to :card
	belongs_to :card_set
end
