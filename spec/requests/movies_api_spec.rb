require 'rails_helper'

describe 'MovieModel API' do
  context 'GET /api/v1/movies' do
    it 'and list all movies' do
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-688457d97fa4',
                    title: '13 Reasons Why', genre: 'TV Show', release_year: '2020',
                    country: 'United States', date_added: '2020-05-07',
                    description: 'A classmate receives a series of tapes that
                    unravel the mystery of her tragic choice.')

      get '/api/v1/movies'

      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['title']).to eq '13 Reasons Why'
    end
    it 'filter movies by title' do
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-655',
                    title: '13 Reasons Why', genre: 'TV Show',
                    release_year: '2020', country: 'United States')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-389',
                    title: 'Hobbit', genre: 'Movie',
                    release_year: '2018', country: 'England')

      get '/api/v1/movies?title=13 Reasons Why'

      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['title']).to eq '13 Reasons Why'
      expect(response.body).not_to include('Hobbit')
    end

    it 'filter movies by genre' do
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-655',
                    title: '13 Reasons Why', genre: 'TV Show',
                    release_year: '2020', country: 'United States')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-389',
                    title: 'Hobbit', genre: 'Movie',
                    release_year: '2018', country: 'England')

      get '/api/v1/movies?genre=TV Show'

      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['title']).to eq '13 Reasons Why'
      expect(parsed_response[0]['genre']).to eq 'TV Show'
      expect(response.body).not_to include('Movie')
      expect(response.body).not_to include('Hobbit')
    end

    it 'filter movies by year' do
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-655',
                    title: '13 Reasons Why', genre: 'TV Show',
                    release_year: '2020', country: 'United States')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-389',
                    title: 'Hobbit', genre: 'Movie',
                    release_year: '2018', country: 'England')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-655',
                    title: 'Atlanta', genre: 'TV Show',
                    release_year: '2020', country: 'United States')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-389',
                    title: 'Queen & Slim', genre: 'Movie',
                    release_year: '2018', country: 'United States')

      get '/api/v1/movies?year=2020'

      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['title']).to eq '13 Reasons Why'
      expect(parsed_response[1]['title']).to eq 'Atlanta'
      expect(response.body).not_to include('Hobbit')
      expect(response.body).not_to include('Queen & Slim')
    end

    it 'filter movies by country' do
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-655',
                    title: '13 Reasons Why', genre: 'TV Show',
                    release_year: '2020', country: 'United States')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-389',
                    title: 'Hobbit', genre: 'Movie',
                    release_year: '2018', country: 'England')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-655',
                    title: 'Atlanta', genre: 'TV Show',
                    release_year: '2020', country: 'United States')
      Movie.create!(index: '840c7cfc-cd1f-4094-9651-389',
                    title: 'Queen & Slim', genre: 'Movie',
                    release_year: '2018', country: 'United States')

      get '/api/v1/movies?country=United States'

      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_response[0]['title']).to eq '13 Reasons Why'
      expect(parsed_response[1]['title']).to eq 'Atlanta'
      expect(parsed_response[2]['title']).to eq 'Queen & Slim'
      expect(response.body).not_to include('Hobbit')
    end
    it 'and there is no movie' do
      get '/api/v1/movies'

      expect(response.status).to eq 200
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_response).to eq []
    end
  end

  context 'POST /api/v1/movies/update' do
    it 'successfully' do
      file = fixture_file_upload('netflix_titles.csv', 'csv')
      headers = { 'Content_Type' => 'text/csv' }
      data = { movies: file }

      post '/api/v1/movies/update', params: data, headers: headers

      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(response.content_type).to include('application/json')
      expect(parsed_response['msg']).to eq('O catálogo está atualizado.')
    end
  end
end
