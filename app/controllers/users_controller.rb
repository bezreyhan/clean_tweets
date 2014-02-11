
class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
    flash[:notice] = "you signed up. Your email is #{params[:user][:email]}."
  	redirect_to stream_user_path(user_params)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.update(user_params)
  	redirect_to users_path
  end	

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to users_path
  end

  def stream

  end	

  private 

  def user_params 
  	params.require(:user).permit(:email, :password)
  end		
end
