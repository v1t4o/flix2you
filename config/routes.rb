Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/movies/update', to: 'movies#update'
      resources :movies, only: %i[index]
    end
  end
end
