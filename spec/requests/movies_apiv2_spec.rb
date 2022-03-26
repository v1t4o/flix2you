require 'rails_helper'
require 'net/http'

describe 'MovieModel API' do
    context 'GET /api/v2/movies' do
        it 'successfully' do
            #Arrange
            Movie.create!(index: "840c7cfc-cd1f-4094-9651-688457d97fa4",
                          title: "13 Reasons Why", genre: "TV Show", release_year: "2020",
                          country: "United States", date_added: "2020-05-07",
                          description: "A classmate receives a series of tapes that
                                        unravel the mystery of her tragic choice."
                         )

            #Act
            get '/api/v2/movies'

            #Assert
            parsed_response = JSON.parse(response.body)
            expect(response.status).to eq 200
            expect(response.content_type).to include('application/json')
            expect(parsed_response[0]["title"]).to eq '13 Reasons Why'
        end
    end

    context 'POST /api/v2/movies/update' do
        it 'successfully' do
            file = fixture_file_upload('netflix_titles.csv', 'csv')
            headers = { 'Content_Type' => 'text/csv'}
            data = { movies: file}

            post '/api/v2/movies/update', params: data, headers: headers

            expect(response.status).to eq 201
            parsed_response = JSON.parse(response.body)
            expect(response.content_type).to include('application/json')
            expect(parsed_response["msg"]).to eq('O catálogo está atualizado.')
        end
    end

    context 'GET /api/v2/movies/' do
        it 'successfully' do
            Movie.create!(index: "840c7cfc-cd1f-4094-9651-688457d97fa4",
                          title: "13 Reasons Why", genre: "TV Show", release_year: "2020",
                          country: "United States", date_added: "2020-05-07",
                          description: "A classmate receives a series of tapes that
                                        unravel the mystery of her tragic choice."
                         )

            get '/api/v2/movies?genre=TV Show'

            expect(response.status).to eq 200
            parsed_response = JSON.parse(response.body)
            expect(response.content_type).to include('application/json')
            expect(response.body).to include('TV Show')
            expect(response.body).to include('13 Reasons Why')
        end
    end
end