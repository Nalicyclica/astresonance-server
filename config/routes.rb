Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :musics, only: [:index, :create, :show]
  resources :titles, only: [:create]
end
