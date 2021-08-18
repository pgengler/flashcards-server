class CardsCardSet < ApplicationRecord
  belongs_to :card
  belongs_to :card_set
end
