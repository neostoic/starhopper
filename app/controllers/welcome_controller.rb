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
