Rails.application.routes.draw do
  devise_for :users , controllers: {registrations: 'users/registrations'}
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root 'assigns#home'
  
  root 'pages#home'
  resources :projects
  resources :reports
  resources :assigns
  # Defines the root path route ("/")
  # root "articles#index"
end
