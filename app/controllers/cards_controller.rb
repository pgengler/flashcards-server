class CardsController < ApplicationController
  def index
		@cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
    @card = Card.find(params[:id])
  end
end
