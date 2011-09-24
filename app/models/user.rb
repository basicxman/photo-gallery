class User < ActiveRecord::Base
  attr_accessible :username, :password

  has_secure_password

  has_many :images
  has_many :galleries

  validates_uniqueness_of :username
end
