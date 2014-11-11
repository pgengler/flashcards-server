Rails.application.routes.draw do
	get 'cards/random' => 'cards#random', as: :random_card
	resources :cards, except: [ :index ]
	root to: 'cards#random'
end
