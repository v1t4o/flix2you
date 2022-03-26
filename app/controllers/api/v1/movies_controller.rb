require 'csv'

class Api::V1::MoviesController < Api::V1::ApiController
    def index
        @movies = Movie.all.order(release_year: :desc)
    end

    def index_filtered
        @movies = Movie.all.order(release_year: :desc)

        return @movies if params[:term].nil?

        @movies = Movie.where("#{params[:filter]} LIKE ?", "%#{params[:term]}%")
    end

    def update
        table_movies = CSV.parse(File.read('netflix_titles.csv'), headers: true)
        movies = table_movies.map(&:to_h)
        movies.each do |movie|
            result = Movie.find_by(index: movie["show_id"])
            if result.nil?
                Movie.create!(index: movie["show_id"],
                              title: movie["title"], genre: movie["type"], director: movie["director"],
                              cast: movie["cast"], country: movie["country"],
                              date_added: movie["date_added"], release_year: movie["release_year"],
                              rating: movie["rating"], duration: movie["duration"], 
                              listed_in: movie["listed_in"], description: movie["description"]
                             )
            end
        end
        render json: {"msg": "O catálogo está atualizado."}, status: 200
    end
end

# 
