class WelcomeController < ApplicationController

  def index

  end

  def map

    if current_user
      @favorites = Favorite.all
      if @favorites.where(user_id: current_user.id)
          @user_favs = @favorites.where(user_id: current_user.id)
      end
    end

    gon.center_point = {lat: 39.9500, lng: -75.1667}
    
  end

  def create

    if current_user
      @favorites = Favorite.all
      if @favorites.where(user_id: current_user.id)
          @user_favs = @favorites.where(user_id: current_user.id)
          @user = User.find(current_user)
      end
    end

    # set instance variables from search form
    
    @offset = 0
    @favorite = params[:favorite]

    if @favorite
      @term = @favorite[:term]
      @radius = @favorite[:radius_filter]
      @location = @favorite[:location]
      @rating = @favorite[:rating].to_f
      whole_city = Yelp.client.search(@location)
    else
      @term = params[:term]
      @radius = params[:radius_filter]
      @location = params[:location]
      @rating = params[:rating].to_f
      whole_city = Yelp.client.search(@location)
    end

    # setting the center_point variable
    # to be used in js file to set the center point
    # of the main map

    ctr_latitude = whole_city.region.center.latitude
    ctr_longitude = whole_city.region.center.longitude

    gon.center_point = {lat: ctr_latitude, lng: ctr_longitude}

    # using search params

    def map_params(location, term, radius, offset)
        Yelp.client.search(@location, {term: term, radius_filter: radius, offset: offset})
    end

    # city_values is a collection of values compiled
    # from 20 searches using a for-loop.
    # Each search returns 20 arrays of data.

    @city_values = []

    for i in 0..19 do
      biz = map_params(@location, @term, @radius, @offset)

      if !biz.businesses.empty?
        @city_values << biz
        @offset+=20
      else
        break
      end
    end

      # Next we set variable for @counter, @rating_match and gon.coordinates
      # then loop through each index of the city_values object
      # and return an array of businesses, then loop through each 
      # business in the array store the coordinates in
      # the gon.coordinates variable to be used in js.
      # js will in turn plot each business on the map.

    @counter = 0
    @rating_match = []
    gon.coordinates = []

    for c in 0...@city_values.length

      @city_values[c].businesses.each do |store|
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
