jeff = User.new(email: "test@test.com", username: "jeff", password: "test")
mike = User.new(email: "test2@test.com", username: "mike", password: "test")

whipp = Course.new(name: "Whippoorwill", score_card: "4, 4, 5, 3, 4, 5, 4, 3, 4, 4, 3, 4, 4, 4, 4, 5, 3, 4")
glen = Course.new(name: "Glen Arbor", score_card: "5, 4, 3, 4, 5, 4, 3, 5, 4, 4, 3, 5, 4, 3, 5, 4, 3, 4")

(1..5).each do |x|
  i = Score.new(score: Array.new(18) { rand(3..7)}.join(", "))
  j = Score.new(score: Array.new(18) { rand(3..7)}.join(", "))

  i.save
  j.save

  jeff.scores << i
  mike.scores << j

  coin_flip = rand(2)
  coin_flip == 0 ? (whipp.scores << i; glen.scores << j) : (whipp.scores << j; glen.scores << i)
end

jeff.save
mike.save
whipp.save
glen.save
