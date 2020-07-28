Rails.application.routes.draw do
 
  root 'welcome#home'
  get('/about', { to: 'welcome#about', as: :about })
  get('/contact_us', { to: 'welcome#contact_us', as: :contact })
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match(
    "/delayed_job",
    to: DelayedJobWeb,
    anchor: false,
    via: [:get, :post]
  )
  
  get('/home', to: 'welcome#home')
  
  
  post('/thank_you', to: 'welcome#thank_you')

  #bill splitter
  get '/bill_splitter', to: 'bill_splitter#new'
  post '/calculate_split', to: 'bill_splitter#create'

  # Session Routes
  resource :session, only: [:new, :create, :destroy]

  # RESTful Product Routes
  #  get '/products/new', to: 'products#new', as: :new_product
  #  post '/products', to: 'products#create'
  #  get '/products/:id', to: 'products#show', as: :product
  #  get '/products', to: 'products#index'
  #  delete '/products/:id', to: 'products#destroy'
  #  get '/products/:id/edit', to: 'products#edit', as: :edit_product
  #  patch '/products/:id', to: 'products#update'

  resources :products do
    resources :reviews, shallow: :true, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :votes, only: [:create, :update, :destroy]
    end
    resources :favourites, shallow: true, only: [:create, :destroy]
  end

  resources :news_articles
  resources :favourites, only: [:index]

  resources :users, only: [:new, :create]

  namespace :admin do 
    resources :dashboard, only: [:index]
  end


  resources :users, only: [:new, :create]
end
