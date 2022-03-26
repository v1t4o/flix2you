require 'csv'

class Api::V2::MoviesController < Api::V2::ApiController
    def index
        movies_params = params.permit(:title, :genre, :year, :country)
        
        return @movies = Movie.all.order(release_year: :desc) if movies_params.empty?

        @movies = Movie.where(search)      
    end

    def index_filtered
        @movies = Movie.all.order(release_year: :desc)

        return @movies if params[:term].nil?

        @movies = Movie.where("#{params[:filter]} LIKE ?", "%#{params[:term]}%")
    end

    def update
        path = params.require(:movies)
        
        File.open(Rails.root.join('public', 'uploads', path.original_filename), 'wb') do |file|
          file.write(path.read)
        end

        table_movies = CSV.parse(File.read("./public/uploads/#{path.original_filename}"), headers: true)
        
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

        File.delete(Rails.root.join('public', 'uploads', path.original_filename))

        render json: {"msg": "O catálogo está atualizado."}, status: 201
    end

    private

    def search
        query = {}
        query[:title] = params[:title] unless params[:title].nil?
        query[:genre] = params[:genre] unless params[:genre].nil?
        query[:release_year] = params[:year] unless params[:year].nil?
        query[:country] = params[:country] unless params[:country].nil?
        query
    end
end
