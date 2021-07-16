class CardSet < ApplicationRecord
	has_and_belongs_to_many :cards

	validates :name, presence: true, uniqueness: true
end
