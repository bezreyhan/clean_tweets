
require 'bcrypt'

class User
	include Mongoid::Document

	attr_accessor :password	

	field :name, type: String
	field :username, type: String
	field :email, type: String
	field :salt, type: String
	field :hashed_password, type: String
	field :access_token, type: String
	field :access_token_secret, type: String

	has_and_belongs_to_many :fav_tweets

	def authenticated? pwd
	  	self.hashed_password ==
	  	  BCrypt::Engine.hash_secret(pwd, self.salt)
	end

	def from_omniauth(auth)
		# auth = request.env['omniauth.auth']
		self.username = auth["info"]["nickname"]
		self.name = auth["info"]["name"]
		self.access_token = auth["credentials"]["token"]
		self.access_token_secret = auth["credentials"]["secret"]
		save!
		# raise self.inspect
		self
	end

	def twitter
		@twitter ||= Twitter::REST::Client.new do |config|
		  config.consumer_key        = "EGtAiRXlnFzX90MPtkHA"
		  config.consumer_secret     = "OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U"
		  config.access_token        = access_token
		  config.access_token_secret = access_token_secret
		end
		# @twitter ||= Twitter::REST::Client.new(access_token: access_token, access_token_secret: access_token_secret)
	end 

	before_save :hash_the_password

	private 

  	def hash_the_password
  		self.salt = BCrypt::Engine.generate_salt
  		self.hashed_password = BCrypt::Engine.hash_secret self.password, self.salt
  		self.password = nil
  	end	
end
