# Game Variables
# 4 digit safe combination generated randomly each run 
safe_combination = rand(1000...10000)
safe = "full"

locations_hash = {
  'passage': {
    description: "You are in a dimly-lit passage.",
    look: Proc.new { puts "The walls drip with an unidentifiable ooze, and there appears to be a cave to the north." },
    movement: {
      north: "cave",
      east: "passage",
      south: "passage",
      west: "passage"
    }
  },
  'cave': {
    description: "You are in a draughty cave.",
    look: Proc.new { puts "It is brighter in here than in the passage, but not by much. You can make out a ladder on the north wall." },
    movement: {
      north: "hall",
      east: "cave",
      south: "passage",
      west: "cave"
    }
  },
  'hall': {
    description: "You are in a hall with a marble floor.",
    look: Proc.new { puts "You see three doors: one each to the north, east, and west." },
    movement: {
      north: "study",
      east: "outside",
      south: "cave",
      west: "cell"
    }
  },
  'study': {
    description: "You are in a warm and cosy study.",
    look: Proc.new { puts "You see a desk with documents on it, and what appears to be a safe underneath the desk." },
    look_at_desk: "You see a piece of paper that reads, The combination is #{safe_combination}.",
    look_at_safe: "You see a sturdy safe firmly attached to the floor, it looks like it needs a 4 digit combination.",
    movement: {
      north: "study",
      east: "study",
      south: "hall",
      west: "study"
    }
  },
  'outside': {
    description: "You emerge into sunlight, and look out across rolling hills.",
    movement: {
      north: "outside",
      east: "outside",
      south: "outside",
      west: "hall"
    }
  },
  'cell': {
    description: "You are in a grimy prison cell.",
    look: method(:cellInteraction),
    movement: {
      north: "cell",
      east: "hall",
      south: "cell",
      west: "cell"
    }
  }
}