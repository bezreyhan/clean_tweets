
class FavTweet
  include Mongoid::Document
  field :tweet_id, type: Integer
  field :text, type: String
  field :username, type: String

  has_and_belongs_to_many :users

  def self.rank_tweets(tweets)
    tweets.each do |tweet|
      retweet_count = tweet.attrs[:retweet_count]
      favorite_count = tweet.attrs[:favorite_count]
      rank = retweet_count + favorite_count
      tweet.attrs[:rank] = rank 
    end
    return tweets
  end

  def self.sort_tweets(ranked_tweets)
    ranked_tweets.sort_by!{|tweet| -tweet.attrs[:rank]}
  end

end
