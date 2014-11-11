Rails.application.routes.draw do
	get 'cards/random' => 'cards#random', as: :random_card
	get 'cards/random/front' => 'cards#random_front', as: :random_card_front
	get 'cards/random/back' => 'cards#random_back', as: :random_card_back
	resources :cards, except: [ :index ]
	root to: 'cards#random'
end
