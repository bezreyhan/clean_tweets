class FavTweetsController < ApplicationController

	# @@client = Twitter::REST::Client.new do |config|
	#   config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
	#   config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
	#   config.access_token        = "1954867038-kJt856202uhmLi0yP4PtUgnLaUHHpzltEpYqaI6"
	#   config.access_token_secret = "UplyBRhTgfmSE5EICNsTVTV8s9A7u4RypqIYQd5vWXMpu"
	# end
	
	def index
	end

	def new
	end

	def destroy
	end

	def get_user_data
		current_user.from_omniauth(request.env['omniauth.auth'])
		redirect_to show_tweets_path
	end 	

	def show_tweets
		# current_user.from_omniauth(request.env['omniauth.auth'])
		ht = current_user.twitter.home_timeline(count: 100)
		## filter out tweets that don't have a link
		home_timeline = ht.find_all {|tweet| tweet.text.include?("http")}
		ranked_tweets = FavTweet.rank_tweets(home_timeline)
		@sorted_tweets = FavTweet.sort_tweets(ranked_tweets)
		binding.pry
	end

	def create
		# puts "************************#{params[:format]}******************************"
		# puts "************************#{current_user.twitter.status(params[:format]).user.user_name}******************************"
		## if that tweet was never created then create and add it to current user's fav_tweets
		if FavTweet.all.where(tweet_id: params[:format]).empty?
			@fav_tweet = FavTweet.create(tweet_id: params[:format])
			current_user.fav_tweets << @fav_tweet
		## if the tweet was created, check if exists in current_user's fav_tweets	
		elsif check_fav_tweets(params[:format]) == true
				flash[:notice] = "You already favorited that tweet"
		else
			## if the tweet doesn't exist in the current_user's fav_tweets then add it.
			@fav_tweet = FavTweet.all.find_by(tweet_id: params[:format])
			current_user.fav_tweets << @fav_tweet
		end	 
		redirect_to show_tweets_path
	end

	def favorites
		@fav_tweets = current_user.fav_tweets
		@fav_tweet_ids = @fav_tweets.map { |tweet| tweet.tweet_id}

		# @client = Twitter::REST::Client.new do |config|
		#   config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
		#   config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
		#   config.access_token        = "1954867038-kJt856202uhmLi0yP4PtUgnLaUHHpzltEpYqaI6"
		#   config.access_token_secret = "UplyBRhTgfmSE5EICNsTVTV8s9A7u4RypqIYQd5vWXMpu"
		# end
	end

	def delete_favorite
		cu = current_user
		tw = FavTweet.find_by(tweet_id: params[:tweet_id])
		cu.fav_tweet_ids -= [tw.id]
		tw.user_ids -= [cu.id]
		cu.save
		tw.save
		redirect_to favorites_fav_tweet_path
	end	

	private 

	def fav_tweet_params 
		params.require(:fav_tweet).permit(:username, :text, :id)
	end

	def check_fav_tweets(tweet_id)
		current_user.fav_tweets.each do |tweet|
			if tweet.tweet_id == tweet_id
				return true
			end
		end	
	end	

end
