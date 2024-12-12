require 'httparty'

namespace :streaming_data do
  desc "Fetch depuis l'API Streaming Availability"
  task :fetch, [:platforms] => :environment do |t, param|
    RAPID_API_KEY = ENV['RAPID_API_KEY']
    BASE_URL = 'https://streaming-availability.p.rapidapi.com/shows/search/filters'
    COUNTRY = 'fr'

    platforms = param[:platforms]&.split(',') || []
    if platforms.empty?
      puts "Veuillez spécifier au moins une plateforme. ex : rails streaming_data:fetch[netflix,prime]"
      exit
    end

    def fetch_data(platform, cursor = nil)
      response = HTTParty.get(BASE_URL, {
        headers: {
          'X-RapidAPI-Key' => RAPID_API_KEY,
          'X-RapidAPI-Host' => 'streaming-availability.p.rapidapi.com'
        },
        query: {
          country: COUNTRY,
          catalogs: platform,
          cursor: cursor
        }
      })

      if response.success?
        JSON.parse(response.body)
      else
        puts "erreur récupération données : #{response.code} - #{response.message}"
        nil
      end
    end

    def save_movie(show_data)
      movie = Movie.find_or_initialize_by(streaming_api_id: show_data['id'])
      movie.update(
        streaming_api_id: show_data['id'],
        tmdb_id: show_data['tmdbId'],
        title: show_data['title'],
        real: show_data['directors'].join(', '),
        cast: show_data['cast'].join(', '),
        genres: show_data['genres'].map { |g| g['name'] }.join(', '),
        release_year: show_data['releaseYear'],
        runtime: show_data['runtime'],
        overview: show_data['overview'],
        rating: show_data['rating'],
        show_type: show_data['showType'],
        vertical_image_url: show_data['imageSet']['verticalPoster']['w600'],
        horizontal_image_url: show_data['imageSet']['horizontalPoster']['w720']
      )
      movie
    end

    def save_service_data(movie, streaming_option)
      service_data = streaming_option['service']
      service = Service.find_or_create_by(service: service_data['id']) do |s|
        s.service_logo_link = service_data['imageSet']['lightThemeImage']
        # recupere le logo de la plateforme de streaming
      end

      ServiceShow.find_or_initialize_by(service: service, movie: movie).update(
        link: streaming_option['link'],
        access_type: streaming_option['type'] # attention différentes souscriptions
      )
    end

    platforms.each do |platform|
      puts "récupération des données du catalogue #{platform}..."
      cursor = nil
      has_more = true

      while has_more
        data = fetch_data(platform, cursor)
        break unless data

        data['shows'].each do |show_data|
          movie = save_movie(show_data)
          streaming_options = show_data['streamingOptions'][COUNTRY] || []

          streaming_options.each do |option|
            save_service_data(movie, option)
          end
        end

        has_more = data['hasMore']
        cursor = data['nextCursor']
        puts "Récupération de #{data['shows'].count} shows. Has more: #{has_more}"

        sleep 1 # ralentir
      end
    end

    puts "Fin de la récupération des catalogues pour: #{platforms.join(', ')}"
  end
end
