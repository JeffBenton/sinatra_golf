david = User.new(email: "david@test.com", username: "David", password: "test", is_admin: true)
mike = User.new(email: "mike@test.com", username: "Mike", password: "test", is_admin: false)
janet = User.new(email: "janet@test.com", username: "Janet", password: "test", is_admin: false)

whipp = Course.new(name: "Whippoorwill", score_card: "4, 4, 5, 3, 4, 5, 4, 3, 4, 4, 3, 4, 4, 4, 4, 5, 3, 4")
glen = Course.new(name: "Glen Arbor", score_card: "5, 4, 3, 4, 5, 4, 3, 5, 4, 4, 3, 5, 4, 3, 5, 4, 3, 4")
pebble = Course.new(name: "Pebble Beach", score_card: "4, 5, 4, 4, 3, 5, 3, 4, 4, 4, 4, 3, 4, 5, 4, 4, 3, 5")
bethpage = Course.new(name: "Bethpage Black", score_card: "4, 4, 3, 5, 4, 4, 5, 3, 4, 4, 4, 4, 5, 3, 4, 4, 3, 4")

(1..10).each do ||
  i = Score.new(score_card: Array.new(18) { rand(3..7)}.join(", "))
  j = Score.new(score_card: Array.new(18) { rand(3..7)}.join(", "))
  k = Score.new(score_card: Array.new(18) { rand(3..7)}.join(", "))

  i.save
  j.save
  k.save

  david.scores << i
  mike.scores << j
  janet.scores << k


  [i, j, k].each do |score|
    case rand(4)
    when 0
      whipp.scores << score
    when 1
      glen.scores << score
    when 2
      pebble.scores << score
    else
      bethpage.scores << score
    end
  end
end

david.save
mike.save
janet.save
whipp.save
glen.save
pebble.save
bethpage.save