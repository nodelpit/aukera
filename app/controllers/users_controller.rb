class UsersController < ApplicationController
  before_action :authenticate_user! # S'assure que l'utilisateur est connecté

  def show
    @user = current_user # Charge l'utilisateur actuellement connecté
  end

  def edit
    @user = current_user # Charge l'utilisateur pour le formulaire d'édition
  end

  def update
    @user = current_user
    if @user.update(user_params) # Tente de mettre à jour les données du profil
      redirect_to myprofile_path, notice: "Profil mis à jour avec succès." # Redirige en cas de succès
    else
      flash.now[:alert] = "Erreur lors de la mise à jour du profil." # Affiche un message d'erreur
      render :edit # Recharge le formulaire d'édition
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :password, :password_confirmation)
  end
end
