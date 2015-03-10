class CardSetsController < ApplicationController
	def index
		render json: CardSet.all
	end
end
