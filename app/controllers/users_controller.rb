class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @current_user = User.find(current_user)
    @current_profile = Profile.where(user_id: current_user.id).first
  end

  def update
   @current_user = User.find(current_user)
   if @current_user.update(user_params)
    flash[:alert] = "Your profile was updated successfully."
    redirect_to profiles_index_path
  else
    flash[:alert] = "There was a problem updating your profile."
    render :edit
  end
end

  def destroy
    if current_user.destroy
      flash.now[:alert] = "Account successfully deleted!"
    else
      flash.now[:alert] = "There was a problem deleting your account!"
    end
    redirect_to root_path
  end

  private

  def user_params
    allow = [:first_name, :last_name, :email, :password, :password_confirmation, :avatar, profile_attributes: [:birthday, :gender]]
    params.require(:user).permit(allow)
  end

end