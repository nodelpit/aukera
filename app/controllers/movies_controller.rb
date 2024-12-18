class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: %w[index show]

  def index
    @movies = Movie.all

    show_type = params[:show_type] || 'movie'
    @movies = @movies.where(show_type: show_type)

    if params[:search].present? && params[:search][:query].present?
      @movies = @movies.where("title ILIKE ?", "%#{params[:search][:query]}%")
    end

    @movies = @movies.where("genres LIKE ?", "%#{params[:genres].gsub(',', ', ')}%") if params[:genres].present?

    if params[:services].present?
      services = params[:services].split(',')
      @movies = @movies.joins(:services).where("services.service IN (?)", services)
    end

    @movies = @movies.where("runtime <= ?", params[:duration]) if params[:duration].present?
    @movies = @movies.sample(5)

    @playlists = if current_user
                   Playlist.by_recently_updated.where(user_id: current_user.id).limit(5)
                 else
                   [] # vide si pas connecté
                 end
  end

  def show
    @movie = Movie.find(params[:id])
    @services = @movie.services
  end
end
