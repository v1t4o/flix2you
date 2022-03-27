require 'csv'

class Api::V1::MoviesController < Api::V1::ApiController
  def index
    movies_params = params.permit(:title, :genre, :year, :country)

    return @movies = Movie.all.order(release_year: :desc) if movies_params.empty?

    @movies = Movie.where(search).order(release_year: :desc)
  end

  def update
    update_catalog(take_movies_from_csv)

    render json: { msg: 'O catálogo está atualizado.' }, status: :created
  end

  private

  def take_movies_from_csv
    path = params.require(:movies)

    File.binwrite(Rails.root.join('public', 'uploads', path.original_filename), path.read)

    table_movies = CSV.parse(File.read("./public/uploads/#{path.original_filename}"), headers: true)

    table_movies.map(&:to_h)
  end

  def update_catalog(movies)
    movies.each do |movie|
      next if movie_exists?(movie['show_id']).nil?

      save_movie(movie)
    end

    File.delete(Rails.root.join('public', 'uploads', params.require(:movies).original_filename))
  end

  def movie_exists?(index)
    Movie.find_by(index: index)
  end

  def save_movie(movie)
    Movie.create!(index: movie['show_id'], title: movie['title'], genre: movie['type'], director: movie['director'],
                  cast: movie['cast'], country: movie['country'],
                  date_added: movie['date_added'], release_year: movie['release_year'],
                  rating: movie['rating'], duration: movie['duration'],
                  listed_in: movie['listed_in'], description: movie['description'])
  end

  def search
    query = {}
    search_by_title(query)
    search_by_genre(query)
    search_by_release_year(query)
    search_by_country(query)
    query
  end

  def search_by_title(query)
    query[:title] = params[:title] unless params[:title].nil?
  end

  def search_by_genre(query)
    query[:genre] = params[:genre] unless params[:genre].nil?
  end

  def search_by_release_year(query)
    query[:release_year] = params[:year] unless params[:year].nil?
  end

  def search_by_country(query)
    query[:country] = params[:country] unless params[:country].nil?
  end
end
