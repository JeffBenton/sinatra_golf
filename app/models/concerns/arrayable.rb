module Arrayable
  def to_array
    self.score_card.split(", ").collect { |num| num.to_i}
  end
end