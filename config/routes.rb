Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get '/movies/update', to: 'movies#update'
      get '/movies', to: 'movies#index'      
      get '/movies/search/:filter/:term', to: 'movies#index_filtered', as: 'movies_search'      
    end

    namespace :v2 do
      post '/movies/update', to: 'movies#update', defaults: { format: :csv }
      get '/movies', to: 'movies#index', defaults: { format: :json }      
      get '/movies/search/:filter/:term', to: 'movies#index_filtered', as: 'movies_search',defaults: { format: :json }      
    end
  end
end
