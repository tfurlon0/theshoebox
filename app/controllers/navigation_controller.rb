class NavigationController < ApplicationController
  skip_before_action :authenticate_user!
  
  def add_cookie
    @user = User.where({ :username => params.fetch(:qs_username) }).first

    if @user != nil && @user.authenticate(params.fetch(:qs_password))
      session[:user_id] = @user.id

      redirect_to("/users/#{@user.username}")
    else
      redirect_to("/sign_in", { :alert => "The username or password you entered is incorrect." })
    end
  end
  
  def sign_out
    reset_session
    
    redirect_to("/sign_in", { :notice => "Signed out successfully." })
  end
  
  def home
    if current_user == nil
      render({ :template => "/navigation/sign_in.html.erb" })
    else
      redirect_to("/users/#{current_user.username}")
    end
  end
  
  def sign_in
    render({ :template => "/navigation/sign_in.html.erb" })
  end
  
  def sign_up
    render({ :template => "/navigation/sign_up.html.erb" })
  end
  
  def settings
    render({ :template => "/navigation/settings.html.erb" })
  end
  
  def shop
    render({ :template => "/navigation/shop.html.erb" })
  end
  
end
