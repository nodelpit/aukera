class MoviePlaylistsController < ApplicationController
  def new
    @movie_playlist = MoviePlaylist.new
    @movie_playlist.movie = Movie.find(params[:movie_id])
    @movie = @movie_playlist.movie
    @playlists = current_user.playlists
  end

  def create
    @movie_playlist = MoviePlaylist.new
    @movie_playlist.playlist = Playlist.find(params[:movie_playlist][:playlist].to_i)
    @movie_playlist.movie = Movie.find(params[:movie_playlist][:movie_id].to_i)
    @movie = @movie_playlist.movie
    if @movie_playlist.save
      @playlist = Playlist.find(params[:movie_playlist][:playlist])
      redirect_to playlist_path(@playlist)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist = Playlist.find(params[:playlist_id])
    @movie_playlist = MoviePlaylist.find_by(movie_id: params[:movie_id].to_i, playlist_id: params[:playlist_id].to_i)
    @movie_playlist.destroy
    redirect_to playlist_path(@playlist), status: :see_other
  end

  private

  def movie_playlist_params
    params.require(:movie_playlist).permit(:movie_id, :playlist_id, :playlist)
  end
end
