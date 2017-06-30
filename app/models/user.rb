class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :secrets, through: :likes
  #to get the likes of instances of User
  has_many :secrets_liked, through: :likes, source: :secret

  validates :name, :email, :password, presence: true
  validates :password, length: { minimum: 4 }
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, format: { with: EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save do 
  	self.email.downcase!
    self.name.capitalize!
  end 
end

# 'User.first.secrets' will query for all the secrets that a user has liked
# 'User.first.secrets_liked' will query for all the secrets that an instance of a User has liked
##this two queries seem to be doing the same thing 