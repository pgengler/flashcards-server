class CardSet < ActiveRecord::Base
	has_many :cards_card_sets
	has_many :cards, through: :cards_card_sets
end
