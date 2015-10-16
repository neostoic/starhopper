class FavoritesController < ApplicationController
  
  def index
  end

  def create
    puts "FAVS"
    puts params

    @rating = params[:rating].to_f
    @term = params[:term]
    @radius = params[:radius_filter]
    @location = params[:location]

    @favorite = Favorite.create(
      user_id: current_user.id,  
      location: @location,
      term: @term,
      rating: @rating,
      radius_filter: @radius);

    puts "SAVED TO FAVORITE!"

  end

  def show
  end

  def update
  end

  def destroy

    @favorite = Favorite.find(params[:id])
    @favorite.destroy

  end

end
