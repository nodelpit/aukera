class MoviesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  
  def index
    @movies = Movie.all

    if params[:search].present? && params[:search][:query].present?
      @movies = @movies.where("title ILIKE ?", "%#{params[:search][:query]}%")
    end

    @movies = @movies.where("genres LIKE ?", "%#{params[:genres]}%") if params[:genres].present?

    if params[:services].present?
      services = params[:services].split(',')
      @movies = @movies.joins(:services).where("services.service IN (?)", services)
    end

    @movies = @movies.where("runtime <= ?", params[:duration]) if params[:duration].present?

    @movies = @movies.sample(5)
    @playlists = Playlist.all
  end

  def show
    @movie = Movie.find(params[:id])
    @services = @movie.services
  end
end
