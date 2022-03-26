Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/movies/update', to: 'movies#update'
      get '/movies', to: 'movies#index'      
      get '/movies/search/:filter/:term', to: 'movies#index_filtered', as: 'movies_search'      
    end
  end
end
