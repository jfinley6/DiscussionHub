Rails.application.routes.draw do
  devise_for :accounts
  get "/u/:username", to: 'public#profile', as: :profile
  
  resources :communities do
    resources :posts, :except => [:index]
  end

  resources :subscriptions, except: :destroy
  delete '/subscriptions/:community_id', to: 'subscriptions#destroy'
  post '/subscriptions/:community_id', to: 'subscriptions#create'

  resources :comments, only: [:create, :destroy]
  
  get '/s/:slug', to: 'links#show'

  post '/posts/vote', to: 'votes#create' 

  #default parameter will soon sort by time
  get '/:sort(/:time)', to: 'posts#index', :defaults => { :time => 'id' } 

  root to: 'posts#index', sort: "front_page"
  
  get '*path' => redirect('/')


end
