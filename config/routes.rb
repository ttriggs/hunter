Rails.application.routes.draw do
  root 'saved_searches#index'

  resources :saved_searches

  resources :listing_results, only: [:show]
end
