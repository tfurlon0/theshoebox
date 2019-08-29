Rails.application.routes.draw do
  
  # Navigation Routes
  
  match("/", { :controller => "navigation", :action => "home", :via => "get" })
  match("/sign_in", { :controller => "navigation", :action => "sign_in", :via => "get" })
  match("/sign_up", { :controller => "navigation", :action => "sign_up", :via => "get" })
  match("/verify_credentials", { :controller => "navigation", :action => "add_cookie", :via => "post" })
  match("/sign_out", { :controller => "navigation", :action => "sign_out", :via => "get" })
  match("/settings/:qs_username", { :controller => "navigation", :action => "settings", :via => "get" })
  match("/shop/:qs_username", { :controller => "navigation", :action => "shop", :via => "get" })
  
  
  # User Routes
  
  match("/post_user", { :controller => "users", :action => "create_profile", :via => "post" })
  match("/users/:qs_username", { :controller => "users", :action => "show", :via => "get" })
  match("/users/:qs_username/own_photos", { :controller => "users", :action => "own_photos", :via => "get" })
  match("/users/:qs_username/own_stats", { :controller => "users", :action => "stats", :via => "get" })
  match("/users/:qs_username/own_locations", {:controller => "users", :action => "locate", :via => "get" })
  match("/discover/:qs_user_id", {:controller => "users", :action => "index", :via => "get" })
  match("/patch_user/:rt_user_id", { :controller => "users", :action => "update", :via => "post" })
  match("/delete_user_warning/:qs_user_id", { :controller => "users", :action => "delete_warning", :via => "get" })
  match("/delete_user/:qs_user_id", {:controller => "users", :action => "destroy", :via => "get" })
  
  # CheckIn Routes
  
  match("/new_check_in/:qs_username", { :controller => "check_ins", :action => "form", :via => "get" })
  match("/create_check_in/:qs_username", { :controller => "check_ins", :action => "create", :via => "post" })
  match("/check_in/:qs_check_in_id/delete", { :controller => "check_ins", :action => "destroy", :via => "get" })

  
  #Location Routes
    
  match("/map/:qs_user_id", { :controller => "locations", :action => "map", :via => "get" })
  match("/locations/:qs_location_id", { :controller => "locations", :action => "show", :via => "get" })
  match("/create_location", { :controller => "locations", :action => "create_form", :via => "get" })
  match("/location_create", { :controller => "locations", :action => "create", :via => "post" })
  
  
  #------------------------------

  # ==============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
