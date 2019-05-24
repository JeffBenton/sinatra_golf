class Course < ActiveRecord::Base
  has_many :scores

  include Arrayable
end