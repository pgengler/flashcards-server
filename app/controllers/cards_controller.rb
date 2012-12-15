class CardsController < ApplicationController
  def index
    @card = Card.random
    if @card
      render :show
    else
      redirect_to new_card_path
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def new
    @card = Card.new
    @form_title = 'New card'
  end

  def create
    @card = Card.create!(params[:card])

    flash[:notice] = 'Card added'
    redirect_to card_path(@card)
  end

  def edit
    @card = Card.find(params[:id])
    @form_title = 'Edit card'
  end

  def update
    @card = Card.find(params[:id])
    @card.update_attributes params[:card]

    flash[:notice] = 'Card saved'
    redirect_to card_path(@card)
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    flash[:notice] = 'Card deleted'
    redirect_to cards_path
  end
end
