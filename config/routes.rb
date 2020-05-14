Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#home'

  resource :home do
      resource :about
    end

  resources :users
  resources :books
end
