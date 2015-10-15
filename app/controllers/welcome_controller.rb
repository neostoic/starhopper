class WelcomeController < ApplicationController

  def index
  end

  def map
    gon.coordinates = [{lat: 39.9500, lng: -75.1667}]
  end

  def create
    
    def map_params(location, term, radius, offset)
      Yelp.client.search(location, {term: term, radius_filter: radius, offset: offset})
    end

    @rating = params[:rating].to_f
    @term = params[:term]
    @radius = params[:radius_filter]
    location = 'Philadelphia'
    offset = 0

    @city_values = []
    @counter = 0
    @rating_match = []

    for i in 0..19 do
      @city_values << map_params(location, @term, @radius, offset)
      offset+=20
    end

    gon.coordinates = []

    if @rating != 0
      for c in 0...@city_values.length

        @stores = @city_values[c].businesses

        @stores.each do |store|
          puts "Store ratings!!!!"
          puts store.rating 
          if store.rating == @rating
            @counter+=1
            @rating_match << store
            gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) rescue nil
          end
        end 
      end
      render 'map'
    else 
      for c in 0...@city_values.length

        @stores = @city_values[c].businesses

        @stores.each do |store|
          @counter+=1
          gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) rescue nil
        end 
      end
      render 'map'
    end
    
  end


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
         :email=> "zkrzyz@gmail.com",
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
