class Card < ActiveRecord::Base
	has_and_belongs_to_many :card_sets

	validates_presence_of :front, :back

	def self.random
		Card.limit(1).order("RANDOM()").first
	end

end
