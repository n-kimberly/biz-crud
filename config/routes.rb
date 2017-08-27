Rails.application.routes.draw do

  resources :advertisements

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :questions

  get 'about' => 'welcome#about'

  # get 'welcome/contact'
  # get 'welcome/faq'

  root 'welcome#index'

end
