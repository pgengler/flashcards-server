Rails.application.routes.draw do
  scope :api do
    jsonapi_resources :collections
    jsonapi_resources :cards
    jsonapi_resources :card_sets
  end
end
