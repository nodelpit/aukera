require 'faker'

User.destroy_all
Service.destroy_all
Movie.destroy_all
Playlist.destroy_all
MoviePlaylist.destroy_all
ServiceShow.destroy_all

genres = ["Action", "Comédie", "Drame", "Fantastique", "Horreur", "Science-fiction", "Romance", "Thriller"]

movies = 20.times.map do
  Movie.create!(
    title: Faker::Movie.title,
    real: Faker::Name.name,
    cast: Faker::Name.name_with_middle,
    genres: Faker::Lorem.words(number: 3).join(', '),
    release_year: Faker::Number.between(from: 1900, to: 2024),
    runtime: Faker::Number.between(from: 60, to: 180),
    overview: Faker::Lorem.sentence(word_count: 15),
    rating: Faker::Number.decimal(l_digits: 1, r_digits: 1),
    show_type: %w[Movie Series].sample,
    video_link: Faker::Internet.url,
    image_url: Faker::Internet.url,
    trailer_link: Faker::Internet.url
  )
end

4.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "aukera",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.between(from: 18, to: 60),
  )

  2.times do
    playlist = Playlist.create!(
      name: genres.sample,   
      description: Faker::Lorem.sentence,
      user: user
    )

    movies.sample(3).each do |movie|
      MoviePlaylist.create!(movie: movie, playlist: playlist)
    end
  end
end

puts "SHOW TIME!"
