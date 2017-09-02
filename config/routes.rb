Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :sponsored_posts, except: [:index]
    resources :posts, except: [:index]
  end

  resources :questions

  resources :users, only: [:new, :create]

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
