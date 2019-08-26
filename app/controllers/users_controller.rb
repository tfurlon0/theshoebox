class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @users = User.all.order({ :username => :asc })

    respond_to do |format|
      format.json do
        render({ :json => @users.as_json })
      end

      format.html do
        render({ :template => "users/index.html" })
      end
    end
  end
  
  def create_profile
    @user = User.new

    @user.username = params.fetch(:qs_username, nil)
    @user.password = params.fetch(:qs_password)
    @user.password_confirmation = params.fetch(:qs_password_confirmation)
    
    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
      
      respond_to do |format|
        format.json do
          render({ :json => @user.as_json })
        end

        format.html do
          redirect_to("/users/#{@user.username}")
        end
      end
    else
      redirect_to("/sign_up", { :alert => "Something went wrong. Please try again." })
    end
  end


  def show
    the_user = params.fetch(:qs_username)
    @user = User.where({ :username => the_user }).first
    @user_check_ins = CheckIn.where({ :owner_id => @user.id })

    respond_to do |format|
      format.json do
        render({ :json => @user.as_json })
      end

      format.html do
        render({ :template => "users/profile_page.html.erb" })
      end
    end
  end

  def own_photos
    the_user = params.fetch(:qs_username)
    user = User.where({ :username => the_user }).first
    user_photos = Photo.where({ :author_id => user.id })
  
    respond_to do |format|
      format.json do
        render({ :json => user_photos.as_json })
      end
    
      format.html do
        render({ :template => "photos/show.html.erb" })
      end
    end
  end
  
  def stats
    the_username = params.fetch(:qs_username)
    @user = User.where({ :username => the_username }).first
    
    @check_in_count = CheckIn.where({ :owner_id => @user.id }).count
    
    @user_location = @user.locations_visited
    
    render({ :template => "users/stats_page.html.erb" })
  end
  
  def locate
    the_username = params.fetch(:qs_username)
    @user = User.where({ :username => the_username }).first
    @user_check_ins = CheckIn.where({ :owner_id => @user.id })
    @user_location = @user.locations_visited
    
    render({ :template => "locations/user_visits.html.erb"})  
  end
  
  def update
    the_user_id = params.fetch(:rt_user_id)
    user = User.where({ :id => the_user_id }).first
    
    user.username = params.fetch(:qs_username, user.username)
    user.bio = params.fetch(:qs_bio, user.bio)
    user.image = params.fetch(:qs_photo, user.image)
    
    user.save
    
    respond_to do |format|
      format.json do 
        render({ :json => user.as_json })
      end
      
      format.html do
        redirect_to("/users/#{user.username}")
      end
    end
  end
end
