namespace :movies do
  desc "Update movies from a CSV file"
  task update_from_csv: :environment do
    require 'csv'

    # Chemin vers le fichier CSV
    csv_file = 'db/imports/movies_v1.csv'  # Remplacez par le chemin réel du fichier CSV

    if File.exist?(csv_file)
      CSV.foreach(csv_file, headers: true) do |row|
        id = row['id']
        title = row['title']
        real = row['real']
        cast = row['cast']
        genres = row['genres']
        release_year = row['release_year']
        runtime = row['runtime']
        overview = row['overview']
        rating = row['rating']
        show_type = row['show_type']
        trailer_link = row['trailer_link']
        vertical_image_url = row['vertical_image_url']
        horizontal_image_url = row['horizontal_image_url']
        season_count = row['season_count']

        # Trouvez le film par l'ID et mettez à jour les informations
        movie = Movie.find_by(id: id)

        if movie
          movie.update(
            title: title,
            real: real,
            cast: cast,
            genres: genres,
            release_year: release_year,
            runtime: runtime,
            overview: overview,
            rating: rating,
            show_type: show_type,
            trailer_link: trailer_link,
            vertical_image_url: vertical_image_url,
            horizontal_image_url: horizontal_image_url,
            season_count: season_count
          )
          puts "Updated movie: #{title} (ID: #{id})"
        else
          puts "Movie not found with ID: #{id}"
        end
      end
    else
      puts "CSV file not found!"
    end
  end
end
