json.array! @movies do |movie|
  json.id movie.index
  json.title movie.title
  json.genre movie.genre
  json.year movie.release_year
  json.country movie.country
  json.published_at movie.date_added
  json.description movie.description
end
