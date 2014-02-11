class FavTweetsController < ApplicationController
	
  def index
  end

  def new
  end

  def destroy
  end

  def show_tweets
  	@client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
	  config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
	  config.access_token        = "1954867038-kJt856202uhmLi0yP4PtUgnLaUHHpzltEpYqaI6"
	  config.access_token_secret = "UplyBRhTgfmSE5EICNsTVTV8s9A7u4RypqIYQd5vWXMpu"
	end

	@home_timeline = @client.home_timeline

	# def home_timeline
	# 	keep_list = []
	# 	@client.home_timeline.each do |tweet|
	# 		if tweet.text.include? "http"
	# 			keep_list << tweet
	# 		end
	# 	end
	# 	return keep_list		
	# end	
  end

  def create
  	@fav_tweet = FavTweet.create(tweet_id: params[:format])
  	current_user.fav_tweets << @fav_tweet
  	redirect_to show_tweets_path
  end

  def display
  end	

  private 

  def fav_tweet_params 
  	params.require(:fav_tweet).permit(:username, :text, :id)
  end		

end

