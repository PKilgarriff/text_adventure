# debug = true if ARGV.first == "debug"
debug = false
# Game Variables
# 4 digit safe combination generated randomly each run 
safe_combination = rand(1000...10000)
safe = "full"
game_running = true
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
    description: "You are in a scary passage.",
    look: "The walls drip with an unidentifiable ooze, and there appears to be a cave to the north."
  },
  'cave': {
    description: "You are in a scary cave.",
    look: "It is brighter in here than in the passage, but not by much. You see a ladder on the north wall."
  },
  'hall': {
    description: "You are in a hall with a marble floor.",
    look: "You see three doors: one each to the north, east, and west."
  },
  'study': {
    description: "You are in a warm and cosy study.",
    look: "You see a desk with documents on it, and what appears to be a safe underneath the desk.",
    look_at_desk: "You see a piece of paper that reads, The combination is #{safe_combination}.",
    look_at_safe: "You see a sturdy safe firmly attached to the floor, it looks like it needs a 4 digit combination.",
  },
  'outside': {
    description: "You emerge into sunlight, and look out across rolling hills."
  },
  'cell': {
    description: "You are in a grimy prison cell.",
  }
}

# Player variables
player_alive = true
previous_location = ""
location = "passage"
inventory = []

while game_running
  if first_loop
    puts introduction_text
    first_loop = false
  end
  puts "#{previous_location} #{location}" if debug
  # IMPORTANT to_sym - to coerce the value of location to a symbol you can use to access from the object
  puts locations_hash[location.to_sym][:description] if location != previous_location
  previous_location = location
  input = gets.chomp.downcase if location != "outside"
  case input
  when "quit"
    puts "Bye!"
    # break
    exit
  when 'help'
    puts introduction_text
  end

  if input == "look" && location != "cell"
    puts locations_hash[location.to_sym][:look]
  end

  case location
  when "passage"
    case input
    when "north"
      location = "cave"
    end
  when "cave"
    case input
    when "north"
      location = "hall"
    when "south"
      location = "passage"
    end
  when "hall"
    case input
    when "north"
      location = "study"
    when "east"
      location = "outside"
    when "west"
      location = "cell"
    end
  when "study"
    case input
    when "south"
      location = "hall"
    when "look at desk"
      puts locations_hash[location.to_sym][:look_at_desk]
    when "look at safe"
      puts locations_hash[location.to_sym][:look_at_safe]
    when "enter combination #{safe_combination}"
      if safe == "full"
        safe = "empty"
        inventory.push("diamonds")
        puts "You see some diamonds in the safe, and put them into your pocket."
      else
        puts "You see where the diamonds were, then remember that they are already in your pocket."
      end
    end
  when "cell"
    case input
    when "east"
      location = "hall"
    when "look"
      puts "You see a man shackled to the wall."
      puts 'The man asks you "Is it day or night outside?"'
      response = gets.chomp.downcase
      case response
      when "day"
        puts '"That\'s a relief" the man sighs. "You should look at the desk in the study to the north before you leave."'
      when "night"
        player_alive, game_running = false
        puts '"Oh dear, it must be a full moon then." the man grunts. "Such a shame, you seemed nice."'
        puts "You watch in horror as the man's features shift and buckle under his skin."
        puts "You have just enough time to see him sprout hair and double in size, before the werewolf tears you apart..."
      end
    end
  when "outside"
    game_running = false
  end
end

if player_alive
  if inventory.include?("diamonds")
    puts "You pat the pouch of diamonds in your pocket, excited to spend your treasure."
  else
    puts "You pat your empty pockets, no treasure this time."
  end
  puts "You made it out of the dungeon! Safe travels on the way to your next adventure."
else
  puts "You died in the dungeon! Better luck next time."
end