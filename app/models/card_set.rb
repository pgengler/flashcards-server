class CardSet < ApplicationRecord
	has_and_belongs_to_many :cards
	belongs_to :collection

	validates :name, presence: true, uniqueness: { scope: :collection }
	validates :collection, presence: true
end
