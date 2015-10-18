class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  # edit method gets current_user and nested profile attributes to allow user to modify their data
  def edit
    @current_user = User.find(current_user)
    @current_profile = Profile.where(user_id: current_user.id).first
  end

  # update method passes in user_params (with nested profile attributes).
  # If update is successful, user is redirected to profile page,
  # otherwise a flash alert is shown and the edit page is rendered
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

# destroy method deletes the current user, if successful.  
# Regardless, the user is redirected to the root_path
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
  allow = [:first_name, :last_name, :email, :password, :password_confirmation, :avatar, profile_attributes: [:birthday, :gender, :bio]]
  params.require(:user).permit(allow)
end

end