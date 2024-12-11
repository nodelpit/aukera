class MoviesController < ApplicationController
  def index
    # on veut que les movies correspondent aux filtres du formulaire
    search_results = Movie.all # TODO à modifier
    # on veut 5 movies
    # [...]
    @movies = search_results.sample(5)
  end

  def show
    @movie = Movie.find(params[:id])
    @services = @movie.services
  end
end
