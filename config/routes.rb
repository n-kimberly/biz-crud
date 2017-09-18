Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
    resources :favorites, only: [:create, :destroy]
  end

  resources :questions

  resources :users, only: [:new, :create, :show]

  post 'users/confirm' => 'users#confirm'

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
