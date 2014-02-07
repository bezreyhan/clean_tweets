class FavTweet
  include Mongoid::Document
  field :id, type: Integer
  field :text, type: String
  field :handle, type: String

  belongs_to :user
end
