class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  def to_array
    score.split(", ").collect { |num| num.to_i}
  end
end