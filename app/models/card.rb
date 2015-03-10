class Card < ActiveRecord::Base
	has_many :cards_card_sets
	has_many :card_sets, through: :cards_card_sets

	validates_presence_of :front, :back

	def self.random
		Card.limit(1).order("RANDOM()").first
	end

end
