Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  resources :questions

  resources :users, only: [:new, :create]

  post 'users/confirm' => 'users#confirm'

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
