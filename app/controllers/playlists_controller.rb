class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def show
    @playlist = Playlist.find(params[:id])
    @movies = @playlist.movies
  end

  def new
    @playlist = Playlist.new
  end

  def create
    @playlist = Playlist.new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
