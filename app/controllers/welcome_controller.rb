  class WelcomeController < ApplicationController

  def index

  end

  def map

    @favorites = Favorite.all

    if current_user
      if @favorites.where(user_id: current_user.id)
          @user_favs = @favorites.where(user_id: current_user.id)
      end
    end

    gon.center_point = {lat: 39.9500, lng: -75.1667}
    # gon.coordinates = [{lat: 39.9500, lng: -75.1667}]
  end

  def create

    @favorites = Favorite.all

    if current_user
      if @favorites.where(user_id: current_user.id)
          @user_favs = @favorites.where(user_id: current_user.id)
          @user = User.find(current_user)
      end
    end

    # set instance variables from search form

    @rating = params[:rating].to_f
    @term = params[:term]
    @radius = params[:radius_filter]
    @location = params[:location]
    @offset = 0

    puts "FAVORITE PARAMS!!!"
    @favorite = params[:favorite]
    puts @favorite

    if @favorite
      @favorite_location = @favorite[:location]
      puts @favorite_location
      @term = @favorite[:term]
      @radius = @favorite[:radius_filter]
      @location = @favorite[:location]
    end

    if @favorite

      whole_city = Yelp.client.search(@favorite_location)

    else

      whole_city = Yelp.client.search(@location)

    end


    def map_params(location, term, radius, offset)
      if @favorite
        Yelp.client.search(@favorite_location, {term: term, radius_filter: radius, offset: offset})
      else
        Yelp.client.search(@location, {term: term, radius_filter: radius, offset: offset})
      end
    end

    # setting the center_point variable
    # to be used in js file to set the center point
    # of the main map



    latitude = whole_city.region.center.latitude
    longitude = whole_city.region.center.longitude

    gon.center_point = {lat: latitude, lng: longitude}

    # city_values is a collection of values compiled
    # from 20 searches using a for-loop.
    # Each search returns 20 arrays of data.

    @city_values = []

    for i in 0..19 do
      @city_values << map_params(location, @term, @radius, @offset)
      @offset+=20
    end

    @counter = 0
    @rating_match = []
    gon.coordinates = []

    # this loops through each index of the object
    # and returns an array of business arrays
    # which is stored in the @stores variable

    for c in 0...@city_values.length

      @stores = @city_values[c].businesses

      # this loops through each business in the
      # @stores array and stores the coordinates in
      # the gon.coordinates variable to be used in js.
      # js will in turn plot each business on the map.

      @stores.each do |store|
        if @rating != 0
          if store.rating == @rating
            @counter+=1
            @rating_match << store
            gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) rescue nil
          end
        else
          @counter+=1
          gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) rescue nil
        end
      end
    end
    render 'map'

  end

  # sendmail method uses mandrill API to send contact form data to teamstarhopper@gmail.com
  def sendmail
    @name=params[:name]
    @email=params[:email]
    @body=params[:body]

    m = Mandrill::API.new
    message = {
     :subject=> "Customer Email",
     :from_name=> "#{@name}",
     :text=>"",
     :to=>[
       {
         :email=> "teamstarhopper@gmail.com",
         :name=> "Customer Service"
       }
       ],
       :html=>"<html><p>#{@body}</p></html>",
       :from_email=>"#{@email}"
     }
     sending = m.messages.send message
     puts sending

     redirect_to contact_path
     flash[:notice] = "Your message has been sent!"
   end

end
