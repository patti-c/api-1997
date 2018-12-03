Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :conversations, only: [:index, :create, :show]
      resources :messages, only: [:create]
      post '/login', to: 'auth#create'
      get '/userdata', to: 'users#userdata'
      post '/get_conversation', to: 'conversations#get_conversation'
      post '/accept_request', to: 'users#accept_friend_request'
      post '/deny_request', to: 'users#deny_friend_request'
      post '/send_friend_request', to: 'users#send_friend_request'
      post '/logout', to: 'users#logout'
      post '/hide', to: 'users#hide'
      post '/unhide', to: 'users#unhide'
    end
  end

  # mount ActionCable.server, at: '/cable'

end
