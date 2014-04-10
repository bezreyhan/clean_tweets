class FavTweetsController < ApplicationController
	
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
		
		ht = current_user.twitter.home_timeline(count: 200)
		## filter out tweets that don't have a link, or tweets
		# whose only link is from a picture
		filtered_tweets = FavTweet.filter_tweets(ht)
		# home_timeline = ht.find_all {|tweet| tweet.text.include?("http")}
		ranked_tweets = FavTweet.rank_tweets(filtered_tweets)
		@sorted_tweets = FavTweet.sort_tweets(ranked_tweets)
	end

	def create
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
