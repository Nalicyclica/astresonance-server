Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :musics, only: [:index, :create, :show] do
    resources :titles, only: [:create]
  end
  resources :titles, only: [:show] do
    resources :comments, only: [:create]
  end
end
