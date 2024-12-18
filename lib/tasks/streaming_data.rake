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

    def sanitize_value(value, default = '')
      value.present? ? value : default
    end

    def fetch_data(platform, cursor = nil)
      response = HTTParty.get(BASE_URL, {
        headers: {
          'X-RapidAPI-Key' => RAPID_API_KEY,
          'X-RapidAPI-Host' => 'streaming-availability.p.rapidapi.com'
        },
        query: {
          country: COUNTRY,
          output_language: 'fr',
          catalogs: platform,
          cursor: cursor
        }
      })

      if response.success?
        JSON.parse(response.body)
      else
        puts "Erreur récupération données : #{response.code} - #{response.message}"
        nil
      end
    end

    def update_show_attributes(show, show_data)
      show.update!(
        streaming_api_id: show_data['id'],
        tmdb_id: show_data['tmdbId'],
        title: sanitize_value(show_data['title'], 'Titre inconnu'),
        real: sanitize_value(show_data['directors']&.join(', ') || show_data['creators']&.join(', '), 'Inconnu'),
        cast: sanitize_value(show_data['cast']&.join(', '), 'Non spécifié'),
        genres: sanitize_value(show_data['genres']&.map { |g| g['name'] }&.join(', '), 'Non spécifié'),
        release_year: sanitize_value(show_data['releaseYear'] || show_data['firstAirYear'], 'Inconnu'),
        runtime: sanitize_value(show_data['runtime'], 0),
        overview: sanitize_value(show_data['overview'], 'Aucune description disponible'),
        rating: sanitize_value(show_data['rating'], 0),
        show_type: sanitize_value(show_data['showType'], 'Inconnu'),
        vertical_image_url: sanitize_value(show_data.dig('imageSet', 'verticalPoster', 'w600'), 'https://via.placeholder.com/426x597?text=Image+manquante'),
        horizontal_image_url: sanitize_value(show_data.dig('imageSet', 'horizontalPoster', 'w720'), 'https://via.placeholder.com/720x405?text=Image+manquante'),
        season_count: show_data['showType'] == 'series' ? sanitize_value(show_data['seasonCount'], 0) : nil
      )
    end

    def save_movie(show_data)
      movie = Movie.find_or_initialize_by(streaming_api_id: show_data['id'])
      update_show_attributes(movie, show_data)
      movie.save!
      return movie
    end

    def save_series(show_data)
      series = Movie.find_or_initialize_by(streaming_api_id: show_data['id'])
      update_show_attributes(series, show_data)
      series.save!
      return series
    end

    def save_service_data(movie, streaming_option)
      streaming_option[1].each do |option|
        service_data = option['service']

        service = Service.find_or_create_by(service: service_data['id']) do |s|
          s.service_logo_link = service_data.dig('imageSet', 'lightThemeImage')
        end

        ServiceShow.find_or_initialize_by(service: service, movie: movie).update(
          link: option['link'],
          access_type: option['type'] # attention différentes souscriptions
        )
      end
    end

    # LIMITE pour environnement de TEST ===================>
    # film_count = 0
    # =====================================================>
    platforms.each do |platform|
      puts "Récupération des données du catalogue #{platform}..."
      cursor = nil
      has_more = true

      while has_more
        data = fetch_data(platform, cursor)
        break unless data

        puts "Nombre de films déjà stockés : #{Movie.count}"

        data['shows'].each do |show_data|

          if show_data['showType'] == 'movie'
            movie = save_movie(show_data)
          elsif show_data['showType'] == 'series'
            movie = save_series(show_data)
          else
            puts "Type inconnu pour l'élément : #{show_data['title']}"
            next
          end

          if show_data['streamingOptions']
            show_data['streamingOptions'].each do |streaming_option|
              save_service_data(movie, streaming_option)
            end
          else
            puts "Aucune option de streaming trouvée pour #{show_data['title']}"
          end
          # LIMITE pour environnement de TEST ===================>
          # film_count += 1
          # if film_count >= 2000
          #   puts "Limite de 2000 films atteinte, arrêt de la récupération."
          #   break
          # end
        end

        # break if film_count >= 2000

        # =======================================================>

        has_more = data['hasMore']
        cursor = data['nextCursor']
        puts "Récupération de #{data['shows'].count} shows. Has more: #{has_more}"

        # sleep 0.5 # ralentir
      end
    end

    puts "Fin de la récupération des catalogues pour: #{platforms.join(', ')}"
  end
end
