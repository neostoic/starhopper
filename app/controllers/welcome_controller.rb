class WelcomeController < ApplicationController
  def index
  end

  def map

  	def map_params(location, term, radius, offset)
  		Yelp.client.search(location, {term: term, radius_filter: radius, offset: offset})
  	end

  	location = 'Philadelphia'
  	term = "food"
  	radius = 600
  	offset = 0

  	@city20 = map_params(location, term, radius, offset)
  	@city40 = map_params(location, term, radius, offset + 20)
  	@city60 = map_params(location, term, radius, offset + 40)
  	@city80 = map_params(location, term, radius, offset + 40)
  	@city100 = map_params(location, term, radius, offset + 60)
  	@city120 = map_params(location, term, radius, offset + 80)
  	@city140 = map_params(location, term, radius, offset + 100)

   @stores20 = @city20.businesses
   @stores40 = @stores20 + @city40.businesses
   @stores60 = @stores40 + @city60.businesses
   @stores80 = @stores60 + @city80.businesses
   @stores100 = @stores80 + @city100.businesses
   @stores120 = @stores100 + @city120.businesses
   @stores140 = @stores120 + @city140.businesses

   gon.coordinates = []

   @stores140.each do |store|
    gon.coordinates.push({lat: store.location.coordinate.latitude, lng: store.location.coordinate.longitude}) 
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
