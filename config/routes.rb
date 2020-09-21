Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/backgrounds', to: 'backgrounds#show'
      post '/sessions', to: 'sessions#create'
      post '/users', to: 'users#create'
      post '/road_trip', to: 'road_trip#create'
    end
  end
end
