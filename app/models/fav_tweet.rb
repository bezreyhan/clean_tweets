
class FavTweet
  include Mongoid::Document
  field :tweet_id, type: Integer
  field :text, type: String
  field :username, type: String

  has_and_belongs_to_many :users


  def self.filter_tweets(ht)
    filtered_tweets = []

    ht.each do |tweet|
      # find number of link
      num_links = tweet[:text].scan("http").length
      if num_links > 0 
        # if a link isnt from a picture or the tweet has more
        # than one link then the tweet passes
        if tweet.attrs[:entities][:media] == nil || num_links > 1
          filtered_tweets << tweet
        end
      end
    end
    return filtered_tweets
  end


  def self.rank_tweets(tweets)
    tweets.each do |tweet|
      retweet_count = tweet.attrs[:retweet_count]
      if tweet.attrs[:retweeted_status] == nil
        favorite_count = tweet.attrs[:favorite_count]
      else
        favorite_count = tweet.attrs[:retweeted_status][:favorite_count]
      end
      rank = retweet_count + favorite_count
      tweet.attrs[:rank] = rank 
    end
    return tweets
  end

  def self.sort_tweets(ranked_tweets)
    ranked_tweets.sort_by!{|tweet| -tweet.attrs[:rank]}
  end

end
