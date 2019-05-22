class Course < ActiveRecord::Base
  has_many :scores
end