Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :conversations, only: [:index, :create, :show]
      post '/login', to: 'auth#create'
      get '/userdata', to: 'users#userdata'
      post '/get_conversation', to: 'conversations#get_conversation'
    end
  end

  # mount ActionCable.server, at: '/cable'

end
