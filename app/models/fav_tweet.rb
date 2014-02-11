
class FavTweet
  include Mongoid::Document
  field :tweet_id, type: Integer
  field :text, type: String
  field :username, type: String

  belongs_to :user

end
