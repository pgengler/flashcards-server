class CardsController < ApplicationController
	before_filter :find_random_card_or_redirect, only: [ :random, :random_front, :random_back ]
	def index
		render json: Card.all
	end

	def random
		if rand() < 0.5
			random_front
		else
			random_back
		end
	end

	def random_front
		render :show
	end

	def random_back
		tmp = @card.front
		@card.front = @card.back
		@card.back = tmp
		render :show
	end

	def show
		@card = Card.find(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @card }
		end
	end

	def new
		@card = Card.new
		@form_title = 'New card'
	end

	def create
		@card = Card.create!(card_params)

		flash[:notice] = 'Card added'
		redirect_to card_path(@card)
	end

	def edit
		@card = Card.find(params[:id])
		@form_title = 'Edit card'
	end

	def update
		@card = Card.find(params[:id])
		@card.update_attributes card_params

		flash[:notice] = 'Card saved'
		redirect_to card_path(@card)
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy

		flash[:notice] = 'Card deleted'
		redirect_to cards_path
	end

	private

	def card_params
		params.require(:card).permit(:front, :back)
	end

	def find_random_card_or_redirect
		@card = Card.random
		unless @card
			redirect_to new_card_path
		end
	end
end
