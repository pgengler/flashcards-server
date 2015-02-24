Rails.application.routes.draw do
	get 'cards/random' => 'cards#random', as: :random_card
	get 'cards/random/front' => 'cards#random_front', as: :random_card_front
	get 'cards/random/back' => 'cards#random_back', as: :random_card_back
	resources :cards, except: [ :index ]
	root to: 'cards#random'

	scope :api, defaults: { format: :json } do
		get 'cards' => 'cards#index'
		get 'cards/:id' => 'cards#show'
		put 'cards/:id' => 'cards#update'
	end
end
