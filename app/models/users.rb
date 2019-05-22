class User < ActiveRecord::Base
  has_secure_password
  has_many :scores
  has_many :courses, through: :scores
end