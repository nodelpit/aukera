namespace :movies do
  desc "Fetch YouTube trailer links for all movies"
  task fetch_trailers: :environment do
    require 'net/http'
    require 'uri'
    require 'json'

    Movie.where(trailer_link: nil).find_each do |movie|
      begin
        tmdb_id = movie.tmdb_id
        next if tmdb_id.blank?

        url = URI("https://api.themoviedb.org/3/#{tmdb_id}/videos?language=en-US")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        request["Authorization"] = "Bearer #{ENV['TMDB_API_KEY']}"

        response = http.request(request)
        p response
        videos = JSON.parse(response.body)["results"]

        unless videos == []

          trailer = videos.find { |video| video["site"] == "YouTube" }

          if trailer
            trailer_link = "https://www.youtube.com/embed/#{trailer['key']}"
            movie.update(trailer_link: trailer_link)
            puts "Trailer ajouté pour #{movie.title}: #{trailer_link}"
          else
            puts "Pas de trailer trouvé pour #{movie.title}"
          end
        end
      rescue StandardError => e
        puts "Erreur pour #{movie.title} : #{e.message}"
      end
      sleep(0.2)
    end
  end
end
