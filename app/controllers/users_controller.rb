class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = current_user
    @playlists = Playlist.by_recently_updated.where(user_id: current_user.id).limit(5)
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update_photo
    if params[:user][:avatar].present?
      Rails.logger.info ">>> Avatar params: #{params[:user][:avatar]}"
    #  current_user.avatar.purge if current_user.avatar.attached?
      if current_user.avatar.attach(params[:user][:avatar])
        Rails.logger.info ">>> Avatar successfully updated for User #{current_user.id}"
        redirect_to myprofile_path, notice: "Photo de profil mise à jour avec succès."
      else
        Rails.logger.error ">>> Error while updating avatar: #{current_user.errors.full_messages}"
        redirect_to edit_myprofile_path, alert: "Erreur lors de l'ajout de la photo."
      end
    else
      redirect_to edit_myprofile_path, alert: "Aucune photo sélectionnée."
    end
  end

  def create
    @user = User.new(user_params)

    @user.preferred_platforms = params[:user][:preferred_platforms] if params[:user][:preferred_platforms].present?

    if params[:user][:preferred_genres].present?
      @user.preferred_genres = params[:user][:preferred_genres].values.reject(&:blank?)
    end

    if @user.save
      redirect_to myprofile_path, notice: 'Utilisateur créé'
    else
      flash.now[:alert] = 'Erreur'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:user][:services].present?
      submitted_services = params[:user][:services].split(',')

      existing_services = current_user.services.pluck(:service)

      platforms_to_add = submitted_services - existing_services
      platforms_to_remove = existing_services - submitted_services

      current_user.services += Service.where(service: platforms_to_add)

      current_user.services.delete(Service.where(service: platforms_to_remove))
    else
      current_user.services.clear
    end

    if current_user.save
      redirect_to myprofile_path, notice: "Profil mis à jour avec succès."
    else
      redirect_to edit_myprofile_path, alert: "Erreur lors de la mise à jour du profil."
    end
  end


  def destroy
    if @user.destroy
      redirect_to root_path, notice: 'Utilisateur supprimé'
    else
      redirect_to myprofile_path, alert: 'Erreur'
    end
  end

  protected

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :age)
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end


end
