Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/userdata', to: 'users#userdata'
    end
  end

  # mount ActionCable.server => '/cable'

end
