class LocationsController < ApplicationController
  
  def address_to_geo(address)
    require 'open-uri'
    url = "http://maps.google.googleapis.com/maps/api/geocode/json?address" + URI.encode(address)
    parsed_data = JSON.params(open(url).read)
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
    return [lat,lng]
  end
  
  def create
    @location = Location.new
    @location.address = params.fetch(:qs_address)
    @location.name = params.fetch(:qs_name)
    @location.bio = params.fetch(:qs_bio)
    @location.color = ["blue", "red", "purple", "yellow", "green"].sample
    
    latlng = address_to_geo(params[:qs_address])
    @location.lat = latlng[0]
    @location.lng = latlng[1]
    
    if @location.save
      redirect_to("/locations/map.html.erb", :notice => "Place created successfully.")
    else
      render("new")
    end
  end
  
  def show
    @the_location_id = params.fetch(:qs_location_id)
    @the_location = Location.where(:id => @the_location_id)
  end
  
  def map
    render("locations/map.html.erb")
  end
end
