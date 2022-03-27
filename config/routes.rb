Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/movies/update', to: 'movies#update', defaults: { format: :csv }
      get '/movies/(/title/:title)(/genre/:genre)(/year/:year)(/country/:country)', to: 'movies#index', defaults: { format: :json }      
    end
  end
end
