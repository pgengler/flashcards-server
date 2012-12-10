class Card < ActiveRecord::Base

	validates_presence_of :front, :back

	def self.random
		rand_id = rand(Card.count)
		Card.first :conditions => [ 'id >= ?', rand_id ]
	end

end
