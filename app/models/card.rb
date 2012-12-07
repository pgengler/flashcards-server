class Card < ActiveRecord::Base

	def self.random
		rand_id = rand(Card.count)
		Card.first :conditions => [ 'id >= ?', rand_id ]
	end

end
