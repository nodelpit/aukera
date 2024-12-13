require 'faker'

MoviePlaylist.destroy_all
ServiceShow.destroy_all
Playlist.destroy_all
User.destroy_all
ServiceShow.destroy_all
Service.destroy_all
Movie.destroy_all

genres = ["Action", "Comédie", "Drame", "Fantastique", "Horreur", "Science-fiction", "Romance", "Thriller"]
services = ["Amazon Prime", "Netflix", "Disney+", "Arte", "Apple TV"].map do |service_name|
  Service.create!(service: service_name, service_logo_link: "https://images.ctfassets.net/y2ske730sjqp/5QQ9SVIdc1tmkqrtFnG9U1/de758bba0f65dcc1c6bc1f31f161003d/BrandAssets_Logos_02-NSymbol.jpg?w=940")
end

movies = 20.times.map do
  Movie.create!(
    title: Faker::Movie.title,
    real: Faker::Name.name,
    cast: Faker::Name.name_with_middle,
    genres: genres.sample,
    release_year: Faker::Number.between(from: 1900, to: 2024),
    runtime: Faker::Number.between(from: 60, to: 180),
    overview: Faker::Lorem.sentence(word_count: 50),
    rating: Faker::Number.decimal(l_digits: 1, r_digits: 1),
    show_type: %w[Movie Series].sample,
    vertical_image_url: "https://jevaisciner.fr/wp/wp-content/uploads/jvc_posters/Le%20Parrain%20Part%201%20Poster-scaled.jpg",
    horizontal_image_url: "https://vl-media.fr/wp-content/uploads/2022/01/le-parrain-1140x625.jpg",
    trailer_link: Faker::Internet.url
  )
end

movies.each do |movie|
  services.sample(Faker::Number.between(from: 1, to: 5)).each do |service|
    ServiceShow.create!(
      movie: movie,
      service: service,
      link: Faker::Internet.url
    )
  end
end

specific_users = [
  User.create!(
    email: "noahdelpit@protonmail.com",
    password: "aukera",
    first_name: "Noah",
    last_name: "Delpit",
    age: 25,
    service: services.sample
  ),
  User.create!(
    email: "alban.bengounia@gmail.com",
    password: "aukera",
    first_name: "Alban",
    last_name: "Bengounia",
    age: 25,
    service: services.sample
  ),
  User.create!(
    email: "metaypauline@gmail.com",
    password: "aukera",
    first_name: "Pauline",
    last_name: "Metay",
    age: 25,
    service: services.sample
  ),
  User.create!(
    email: "raphaelcanches@gmail.com",
    password: "aukera",
    first_name: "Raphael",
    last_name: "Canches",
    age: 25,
    service: services.sample
  )
]

specific_users.each do |user|
  2.times do
    playlist = Playlist.create!(
      name: "Mes films de #{genres.sample}",
      description: Faker::Lorem.sentence,
      user: user
    )

    movies.sample(3).each do |movie|
      MoviePlaylist.create!(movie: movie, playlist: playlist)
    end
  end
end

puts "SHOW TIME!"
