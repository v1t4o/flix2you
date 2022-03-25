class Api::V1::MoviesController < Api::V1::ApiController
    def index
        @movies = Movie.all.order(release_year: :desc)
    end
end