class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :get_page, :get_route

  def current_user
  	if session[:user_id]
  		User.find(session[:user_id])
  	end	
  end	

  def get_page
  	if params[:controller] == "users"
  		if params[:action] == "new"
  			return "Log In"
  		end
  	elsif params[:controller] == "auths"
  		if params[:action] == "new"
  			"Sign Up"
  		end
  	end		
  end


  def get_route
  	if params[:controller] == "users"
  		if params[:action] == "new"
  			new_auth_path
  		end
  	elsif params[:controller] == "auths"
  		if params[:action] == "new"
  			new_user_path
  		end
  	end	
  end	

end
