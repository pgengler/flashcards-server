class CardsController < ApplicationController
  def index
		@cards = Card.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
