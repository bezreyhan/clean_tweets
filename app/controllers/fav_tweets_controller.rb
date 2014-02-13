class FavTweetsController < ApplicationController

	@@client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
	  config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
	  config.access_token        = "1954867038-kJt856202uhmLi0yP4PtUgnLaUHHpzltEpYqaI6"
	  config.access_token_secret = "UplyBRhTgfmSE5EICNsTVTV8s9A7u4RypqIYQd5vWXMpu"
	end
	
	def index
	end

	def new
	end

	def destroy
	end

	def show_tweets
		# ht = @@client.home_timeline
		# @home_timeline = ht.find_all {|tweet| tweet.text.include?("http")}
		ht = current_user.twitter.home_timeline
		@home_timeline = ht.find_all {|tweet| tweet.text.include?("http")}
	end

	def create
		## if that tweet was already created then don't create tweet.
		if FavTweet.all.where(tweet_id: params[:format]).empty?
			@fav_tweet = FavTweet.create(tweet_id: params[:format]) 
			current_user.fav_tweets << @fav_tweet
		else
			flash[:notice] = "You alreday favorited that tweet"
		end
			redirect_to show_tweets_path

	end

	def favorites
		@fav_tweets = current_user.fav_tweets
		@fav_tweet_ids = @fav_tweets.map { |tweet| tweet.tweet_id}

		@client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
		  config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
		  config.access_token        = "1954867038-kJt856202uhmLi0yP4PtUgnLaUHHpzltEpYqaI6"
		  config.access_token_secret = "UplyBRhTgfmSE5EICNsTVTV8s9A7u4RypqIYQd5vWXMpu"
		end
	end		

	private 

	def fav_tweet_params 
		params.require(:fav_tweet).permit(:username, :text, :id)
	end
end
