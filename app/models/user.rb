
require 'bcrypt'

class User
	include Mongoid::Document

	attr_accessor :password	

	field :name, type: String
	field :user_name, type: String
	field :email, type: String
	field :salt, type: String
	field :hashed_password, type: String

	def authenticated? pwd
	  	self.hashed_password ==
	  	  BCrypt::Engine.hash_secret(pwd, self.salt)
	end

	before_save :hash_the_password

	private 

  	def hash_the_password
  		self.salt = BCrypt::Engine.generate_salt
  		self.hashed_password = BCrypt::Engine.hash_secret self.password, self.salt
  		self.password = nil
  	end	
end
