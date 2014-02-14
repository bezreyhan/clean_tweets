
class AuthsController < ApplicationController

	# show login form
	def new
		if current_user
			#### !!!! update this when you create a tweets page !!!!!
			redirect_to twitter_auth_path
			flash[:notice] = "current_user was true"
		else
			@user = User.new
		end		
	end	

	#Log them in
	def create
		if !(User.where(email: params[:user][:email]).empty?)
			user = User.find_by(email: params[:user][:email])
			# puts "***************************#{params}******************"
			if user.authenticated?(params[:user][:password])
				session[:user_id] = user.id
				#### !!!! update this when you create a tweets page !!!!!
				redirect_to twitter_auth_path
				flash[:notice] = "You are logged in"
			else 
				redirect_to new_auth_path	
				flash[:notice] = "Your Email and Password did not Match "
			end
		else
			redirect_to new_auth_path	
			flash[:notice] = "We couldn't find that email. Try again or create an account."	
		end	
	end

	def destroy
		session[:user_id] = nil
		redirect_to new_auth_path
	end

end	
