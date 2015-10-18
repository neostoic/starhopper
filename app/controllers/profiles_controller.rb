class ProfilesController < ApplicationController
  # Index controller gets current_user and nested profile attributes (bio, gender, birthday)
  def index
    @current_user = User.find(current_user.id)
    @current_profile = Profile.where(user_id: current_user.id).first
  end

  def show

  end

  def new
  end

  def create

  end

  def edit

  end

  def update
    
  end

  def destroy

  end

end
