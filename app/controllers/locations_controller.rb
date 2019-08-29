class LocationsController < ApplicationController
  
  def address_to_geo(address)
    require 'open-uri'
    url = "http://maps.google.googleapis.com/maps/api/geocode/json?address" + URI.encode(address)
    parsed_data = JSON.params(open(url).read)
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
    return [lat,lng]
  end
  
  def create_form
    render("/locations/create.html.erb")
  end
  
  def create
    new_name = params.fetch(:qs_location_name)
    new_address = params.fetch(:qs_address)
    new_image = params.fetch(:qs_image)
    new_bio = params.fetch(:qs_bio)
    
    @location = Location.new
    @location.name = new_name
    @location.address = new_address
    @location.image = new_image
    @location.bio = new_bio
    @location.save
    
    redirect_to("/locations/#{@location.id}")
  end
  
  def show
    @the_location_id = params.fetch(:qs_location_id)
    @the_location = Location.where(:id => @the_location_id)
  end
  
  def map
    user_checkin = CheckIn.where({ :owner_id => current_user.id }).first
    @user_locations = Location.where({ :id => user_checkin })

    render("locations/map.html.erb")
  end
end
