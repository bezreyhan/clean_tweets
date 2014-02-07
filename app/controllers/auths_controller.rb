class AuthsController < ApplicationController

	# show login form
	def new
		if current_user
			#### !!!! update this when you create a tweets page !!!!!
			redirect_to users_path
			flash[:notice] = "current_user was true"
		else
			@user = User.new
		end		
	end	

	#Log them in
	def create 
		user = User.find_by(username: params[:user][:username])
		puts "***************************#{params}******************"
		if user.authenticated?(params[:user][:password])
			session[:user_id] = user.id
			#### !!!! update this when you create a tweets page !!!!!
			redirect_to users_path
			flash[:notice] = "You are logged in"
		else 
			redirect_to users_path	
			flash[:notice] = "Your Email or Password did not Match"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to new_auth_path
	end

end	
