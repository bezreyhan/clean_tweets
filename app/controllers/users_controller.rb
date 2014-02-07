class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)
  	redirect_to users_path
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

  def welcome
  end	

  private 

  def user_params 
  	params.require(:user).permit(:email, :password)
  end		
end
