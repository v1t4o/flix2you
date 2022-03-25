class Api::V1::MoviesController < Api::V1::ApiController
    def index
        movies = Movie.all
        render json: movies.as_json(except: [:address, :created_at, :updated_at]), status: 200
    end
end