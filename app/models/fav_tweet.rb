
class FavTweet
  include Mongoid::Document
  field :tweet_id, type: Integer
  field :text, type: String
  field :username, type: String

  has_and_belongs_to_many :users

end
