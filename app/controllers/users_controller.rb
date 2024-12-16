class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
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
    if @user.update(user_params)
      redirect_to myprofile_path, notice: 'Profil mis à jour'
    else
      flash.now[:alert] = 'Erreur'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path, notice: 'Utilisateur supprimé'
    else
      redirect_to myprofile_path, alert: 'Erreur'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :age,)
  end
end
