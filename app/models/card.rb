class Card < ActiveRecord::Base

	validates_presence_of :front, :back

	def self.random
		Card.limit(1).order("RANDOM()").first
	end

end
