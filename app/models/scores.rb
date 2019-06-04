class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  include Arrayable

  def total_sum(start=0, finish=18)
    self.to_array[start, finish].sum
  end
end