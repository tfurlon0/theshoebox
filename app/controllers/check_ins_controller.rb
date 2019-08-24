class CheckInsController < ApplicationController
  def form
    render({ :template => "/checkins/create.html.erb" })
  end
  
  def create
    @photo = Photo.new
    
    the_user_id = params.fetch(:rt_user_id, nil)
    the_user = User.where({ :id => the_user_id })
    
    the_location_name = params.fetch(:qs_location, nil)
    the_location_id = Location.where({ :name => the_location_name }).first.id
    
    the_caption = params.fetch(:qs_caption)
    
    the_photo = params.fetch(:qs_photo)
    @photo.image = the_photo
    @photo.location_id = the_location_id
    @photo.author_id = the_user_id
    @photo.caption = the_caption
    @photo.save
    
    @check_in = CheckIn.new
    
    @check_in.owner_id = the_user_id
    @check_in.location_id = the_location_id
    @check_in.image = @photo
    @check_in.caption = the_caption
    @check_in.save
    
    respond_to do |format|
      format.json do
        render({ :json => check_in.to_json })
      end
      
      format.html do
        redirect_to("/users/#{current_user.username}")
      end
    end
  end
end
