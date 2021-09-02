Rails.application.routes.draw do
  root to: 'musics#index'
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :musics, only: [:index, :create, :update, :show, :destroy] do
    resources :titles, only: [:create]
  end
  resources :titles, only: [:show, :destroy] do
    resources :comments, only: [:index, :create]
  end
  resources :comments, only: [:destroy]
  resources :users, only: [:show]
end
