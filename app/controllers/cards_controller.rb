class CardsController < ApplicationController
  def index
    @card = Card.random
    render :show
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.create!(params[:card])

    flash[:notice] = 'Card added'
    redirect_to card_path(@card)
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    @card.update_attributes params[:card]

    flash[:notice] = 'Card saved'
    redirect_to card_path(@card)
  end
end
