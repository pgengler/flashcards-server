class CardsController < ApplicationController
	def index
		render json: Card.all
	end

	def show
		@card = Card.find(params[:id])
		render json: @card
	end

	def create
		@card = Card.create!(card_params)
		render json: @card, status: :created
	end

	def update
		@card = Card.find(params[:id])
		@card.update_attributes card_params
		render json: @card
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy
		head :no_content
	end

	private

	def card_params
		params.require(:card).permit(:front, :back)
	end
end
