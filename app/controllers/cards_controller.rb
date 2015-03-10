class CardsController < ApplicationController
	before_filter :find_card, only: [ :show, :update, :destroy ]
	def index
		render json: Card.all
	end

	def show
		render json: @card
	end

	def create
		@card = Card.new(card_params)
		if @card.save
			render json: @card, status: :created
		else
			head :unprocessable_entity
		end
	end

	def update
		@card.update_attributes card_params
		if @card.save
			render json: @card
		else
			head :unprocessable_entity
		end
	end

	def destroy
		@card.destroy
		head :no_content
	end

	private

	def card_params
		params.require(:card).permit(:front, :back)
	end

	def find_card
		@card = Card.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		head :not_found
	end
end
