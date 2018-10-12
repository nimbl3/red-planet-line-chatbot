Rails.application.routes.draw do
  resources :promotions, only: [:show]

  post 'callback', to: 'message#callback'
end
