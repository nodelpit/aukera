class MoviesController < ApplicationController
  def index # rubocop:disable Metrics/MethodLength,Metrics/PerceivedComplexity
    # on veut que les movies correspondent aux filtres du formulaire
    search_results = Movie.all
    # on veut 5 movies

    # Recherche par titre
    if params[:search].present? && params[:search][:query].present?
      search_results = search_results.where("title ILIKE ?", "#{params[:search][:query]}%")
    end

    # Filtrage par type (Films/Séries)
    if params[:toggle] == "1"
      search_results = search_results.where(show_type: "Series")
    else
      search_results = search_results.where(show_type: "Movie")
    end

    # Filtrage par genres
    if params[:genres].present?
      genres = params[:genres].split(',')
      genres.each do |genre|
        search_results = search_results.where("genres ILIKE ?", "%#{genre}%")
      end
    end

    # Filtrage par services (plateformes)
    if params[:services].present?
      services =  params[:services].split(',')
      service_ids = Service.where(service: services).pluck(:id)
      search_results = search_results.joins(:service_shows).where(service_shows: { service_id: service_ids }).distinct
    end

    # Filtrage par durée
    if params[:duration].present?
      max_minutes = (params[:duration].to_i * 2) + 60
      search_results = search_results.where("runtime <= ?", max_minutes)
    end

    @movies = search_results.sample(5)
  end

  def show
    @movie = Movie.find(params[:id])
    @services = @movie.services
  end
end
