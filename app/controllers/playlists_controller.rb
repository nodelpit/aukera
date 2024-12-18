class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.by_recently_updated.where(user_id: current_user.id)
  end

  def show
    @playlist = Playlist.find(params[:id])
    @movies = @playlist.movies.by_recently_updated
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @playlist.user = current_user
    if @playlist.save
      respond_to do |format|
        format.html { redirect_to playlist_path(@playlist) }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @playlist = Playlist.find(params[:id])
  end

  def update
    @playlist = Playlist.find(params[:id])
    if @playlist.update(playlist_params)
      redirect_to playlist_path(@playlist)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    redirect_to playlists_path, status: :see_other
  end

  private

  def playlist_params
    params.require(:playlist).permit(:name, :description, :photo)
  end
end
