class ProfilesController < ApplicationController
  def index
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
