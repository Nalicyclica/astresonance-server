Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :musics, only: [:index, :create, :show, :destroy] do
    resources :titles, only: [:create]
  end
  resources :titles, only: [:show, :destroy] do
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]
end
