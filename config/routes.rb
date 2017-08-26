Rails.application.routes.draw do

  resources :advertisements

  resources :posts

  resources :questions

  get 'about' => 'welcome#about'

  # get 'welcome/contact'
  # get 'welcome/faq'

  root 'welcome#index'

end
