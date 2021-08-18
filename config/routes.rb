Rails.application.routes.draw do
  scope :api do
    jsonapi_resources :collections do
      jsonapi_relationships
      post :import
    end
    jsonapi_resources :cards
    jsonapi_resources :card_sets
  end
end
