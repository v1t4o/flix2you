require 'rails_helper'

describe 'MovieModel API' do
    context 'GET /api/v1/movies' do
        it 'successfully' do
            #Arrange
            Movie.create!(index: "840c7cfc-cd1f-4094-9651-688457d97fa4",
                          title: "13 Reasons Why", genre: "TV Show", release_year: "2020",
                          country: "United States", date_added: "2020-05-07",
                          description: "A classmate receives a series of tapes that
                                        unravel the mystery of her tragic choice."
                         )

            #Act
            get '/api/v1/movies'

            #Assert
            parsed_response = JSON.parse(response.body)
            expect(response.status).to eq 200
            expect(response.content_type).to include('application/json')
            expect(parsed_response[0]["title"]).to eq '13 Reasons Why'
        end
    end

    context 'POST /api/v1/movies' do
        it 'successfully' do
            get '/api/v1/movies/update'

            expect(response.status).to eq 200
            parsed_response = JSON.parse(response.body)
            expect(response.content_type).to include('application/json')
            expect(response.body).to include('O catálogo está atualizado.')
        end
    end
end