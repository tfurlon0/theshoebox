class CheckInsController < ApplicationController
  def form
    the_user = params.fetch(:qs_username, nil)
    @user = User.where({ :username => the_user }).first
    render({ :template => "/checkins/create.html.erb" })
  end
  
  def create
    
    @photo = Photo.new
    
    the_user = params.fetch(:qs_username, nil)
    @user = User.where({ :username => the_user }).first
    @user_check_ins = CheckIn.where({ :owner_id => current_user.id })
    
    the_location_name = params.fetch(:qs_location, nil)
    the_location_id = Location.where({ :name => the_location_name }).first.id

    the_caption = params.fetch(:qs_caption)

    the_photo = params.fetch(:qs_photo)
    @photo.image = the_photo
    @photo.location_id = the_location_id
    @photo.author_id = the_user
    @photo.caption = the_caption
    @photo.save

    @check_in = CheckIn.new

    @check_in.owner_id = @user.id
    @check_in.location_id = the_location_id
    @check_in.image = @photo.image
    @check_in.caption = the_caption
    @check_in.save

    respond_to do |format|
      format.json do
        render({ :json => check_in.to_json })
      end

      format.html do
        redirect_to("/users/#{the_user}")
      end
    end
  end
  
  def destroy
  
    c = params.fetch(:qs_check_in_id)
    check_in = CheckIn.where({ :id => c }).first
    check_in.destroy
    check_in.save
    
    redirect_to("/users/#{current_user.username}")
  end
end
