class Card < ApplicationRecord
	has_and_belongs_to_many :card_sets
	belongs_to :collection

	validates_presence_of :front, :back, :collection

	def self.random
		Card.limit(1).order("RANDOM()").first
	end

end
