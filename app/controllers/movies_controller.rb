class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @movies = Movie.all

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
    @playlists = Playlist.all
  end

  def show
    # session[:previous_url] = request.fullpath
    @movie = Movie.find(params[:id])
    @services = @movie.services
  end

  def back
    redirect_to session.delete(:previous_url) || root_path
  end
end
