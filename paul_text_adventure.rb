require_relative 'game_functions'

if ARGV.include? "debug"
  debug = true
else
  debug = false
end
ARGV.clear

class Safe
  POSSIBLE_TREASURE = [
    "a pouch of diamonds",
    "a bronze spoon",
    "a handful of coins",
    "a picture of a horse"
  ]

  attr_reader :locked

  def initialize(location)
    @location = location
    @locked = true
    @contents = generate_treasure()
    @combination = rand(1000...10000)
  end
  
  def is_empty?
    @contents.empty?
  end

  def generate_treasure
    @contents = POSSIBLE_TREASURE.sample(2)
  end

  def request_safe_combination
    @combination
  end
  
  def safe_information
    puts "The safe is in the #{@location}"
    puts "The safe is locked? #{@locked}"
    puts "The combination is #{@combination}"
    puts "The safe contains #{@contents}"
    puts "The safe is empty? #{is_empty?()}"
  end

  def enter_safe_combination(user_input)
    if user_input.to_i === @combination
      @locked = !@locked
      locked_string = @locked ? "Locked" : "Unlocked"
      puts "Safe is #{locked_string}"
    else
      puts "Incorrect Combination"
      false
    end
  end
end

# Game Variables
# 4 digit safe combination generated randomly each run 
safe_combination = rand(1000...10000)
safe = "full"
$game_running = true
first_loop = true

introduction_text = [
  "Welcome to the Text Adventure!",
  "Move around by typing in one of the compass directions and hitting enter.",
  "You can also type 'look' to get more information about your current location.",
  "If you get stuck, type 'help' to read this message again, or 'quit' to exit the game.",
  "----------------"
]

locations_hash = {
  'passage': {
    description: "You are in a dimly-lit passage.",
    look: Proc.new { puts "The walls drip with an unidentifiable ooze, and there appears to be a cave to the north." },
    identify_ooze: Proc.new { puts "I think we need to talk about the meaning of the word \"unidentifiable\"." },
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
    look_at_desk: Proc.new { puts "You see a piece of paper that reads, The combination is #{study_safe.request_safe_combination}." },
    #    look_at_desk: "You see a piece of paper that reads, The combination is #{study_safe.request_safe_combination}.",
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

study_safe = Safe.new("study")
# puts "The Safe combination is #{study_safe.request_safe_combination}"
study_safe.safe_information
puts c

# Player variables
$player_alive = true
previous_location = ""
location = "passage"
inventory = []

while $game_running
  if first_loop
    puts introduction_text
    first_loop = false
  end
  puts "Previous: #{previous_location} Current: #{location}" if debug == true
  # IMPORTANT to_sym - to coerce the value of location to a symbol you can use to access from the object
  puts locations_hash[location.to_sym][:description] if location != previous_location
  previous_location = location
  input = gets.chomp.downcase if location != "outside"
  case input
  when 'quit'
    puts "Bye!"
    # break
    exit
  when 'help'
    puts introduction_text[1..4]
  when 'look'
    locations_hash[location.to_sym][:look].()
  end

  # puts input
  if ['north', 'east', 'south', 'west'].any? { |direction| direction == input }
    # puts locations_hash[location.to_sym][:movement][input.to_sym]
    location = locations_hash[location.to_sym][:movement][input.to_sym]
    puts "You remain in the #{location}" if location == previous_location
  end

  case location
  when 'study'
    puts "Safe combination is #{study_safesafe_combination}." if debug
    case input
    when 'look at desk'
      locations_hash[location.to_sym][:look_at_desk].()
    when 'look at safe'
      puts locations_hash[location.to_sym][:look_at_safe]
    when "enter combination #{study_safe.request_safe_combination}"
      unless study_safe.is_empty?
        safe = "empty"
        # inventory.push("diamonds")
        puts "The safe contains " 
        puts "You see some diamonds in the safe, and put them into your pocket."
      else
        puts "You see where the diamonds were, then remember that they are already in your pocket."
      end
    end
  when "outside"
    $game_running = false
  end
end

if $player_alive
  if inventory.include?("diamonds")
    puts "You pat the pouch of diamonds in your pocket, excited to spend your treasure."
  else
    puts "You pat your empty pockets, no treasure this time."
  end
  puts "You made it out of the dungeon! Safe travels on the way to your next adventure."
else
  puts "You died in the dungeon! Better luck next time."
end