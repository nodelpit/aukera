class UsersController < ApplicationController

  def remove_genre
    genre_to_remove = params[:genre]
    updated_genres = @user.genres.split(',').reject { |g| g == genre_to_remove }.join(',')
    @user.update(genres: updated_genres)
    redirect_to edit_myprofile_path, notice: "Genre supprimé"
  end

  def remove_platform
    platform_to_remove = params[:platform]
    updated_platforms = @user.platforms.split(',').reject { |p| p == platform_to_remove }.join(',')
    @user.update(platforms: updated_platforms)
    redirect_to edit_myprofile_path, notice: "Plateforme supprimée"
  end

  def remove_playlist
    playlist = Playlist.find(params[:playlist_id])
    if playlist.user_id == @user.id
      playlist.destroy
      redirect_to edit_myprofile_path, notice: "Playlist supprimée"
    else
      redirect_to edit_myprofile_path, alert: "Impossible de supprimer la playlist."
    end
  end

  def update_photo
    if @user.update(photo_params)
      redirect_to edit_myprofile_path, notice: "Photo mise à jour"
    else
      redirect_to edit_myprofile_path, alert: "Impossible de mettre à jour la photo."
    end
  end

  def update_username
    if @user.update(username_params)
      redirect_to edit_myprofile_path, notice: "Nom d'utilisateur mis à jour"
    else
      redirect_to edit_myprofile_path, alert: "Impossible de mettre à jour le nom d'utilisateur."
    end
  end

  private

  def set_user
    @user = current_user
  end

  def photo_params
    params.require(:user).permit(:photo)
  end

  def username_params
    params.require(:user).permit(:username)
  end
end
