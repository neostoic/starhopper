class WelcomeController < ApplicationController
  def index
  end

  def map

  	@city = Yelp.client.search('Chicago', {term: 'food'})
	@stores = @city.businesses

	gon.coordinates = []
	 
	@stores.each do |store|
		gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) 
	end 	
  end
end
