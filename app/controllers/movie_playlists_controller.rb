class MoviePlaylistsController < ApplicationController
  def new
    @movie_playlist = MoviePlaylist.new
    @movie_playlist.movie = Movie.find(params[:movie_id])
    @playlists = current_user.playlists
  end

  def create
    @movie_playlist = MoviePlaylist.new(movie_playlist_params)
    if @movie_playlist.save
      redirect_to playlist_path(@movie_playlist.playlist)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def movie_playlist_params
    params.require(:movie_playlist).permit(:movie_id, :playlist_id)
  end
end
