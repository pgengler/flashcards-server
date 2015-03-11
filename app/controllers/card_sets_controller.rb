class CardSetsController < ApplicationController
	def index
		render json: CardSet.all
	end

	def create
		card_set = CardSet.new(card_set_params)
		if card_set.save
			render json: card_set, status: :created
		else
			head :unprocessable_entity
		end
	end

	private

	def card_set_params
		params.require(:card_set).permit(:name)
	end
end
