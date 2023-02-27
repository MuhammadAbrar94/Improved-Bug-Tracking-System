Rails.application.routes.draw do
  devise_for :users , controllers: {registrations: 'users/registrations'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root 'assigns#home'
  
  root 'pages#home'
  resources :projects
  resources :buges
  resources :assigns
  # Defines the root path route ("/")
  # root "articles#index"
end
