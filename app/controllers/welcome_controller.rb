class WelcomeController < ApplicationController
  
  def index
  end

  def map

  	def map_params(location, term, radius, offset)
  		Yelp.client.search(location, {term: term, radius_filter: radius, offset: offset})
  	end

  	location = 'Philadelphia'
  	term = "food"
  	radius = 2000
  	offset = 0

    @city_values = []

    for i in 0..20 do
      @city_values << map_params(location, term, radius, offset)
      offset+=20
    end

    gon.coordinates = []

    for c in 0...@city_values.length
      @stores = @city_values[c].businesses

      @stores.each do |store|
        puts gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) 
      end 
    end
  end  

end
