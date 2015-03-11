Rails.application.routes.draw do
	scope :api, defaults: { format: :json } do
		resources :cards, except: [ :new, :edit ]
		resources :card_sets, only: [ :index, :create ]
	end
end
