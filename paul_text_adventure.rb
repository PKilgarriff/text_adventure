# debug = true if ARGV.first == "debug"

# Game Variables
location_descriptions = {
  'passage': "You are in a scary passage.",
  'cave': "You are in a scary cave.",
  'hall': "You are in a hall with a marble floor.",
  'study': "You are in a warm and cosy study.",
  'outside': "You emerge into sunlight, and look out across rolling hills.",
  'cell': "You are in a grimy prison cell."
}
# 4 digit safe combination generated randomly each run 
safe_combination = rand(1000...10000)
safe = "full"
game_running = true

# Player variables
player_alive = true
previous_location = ""
location = "passage"
inventory = []

while game_running
  puts "#{previous_location} #{location}" if debug
  # IMPORTANT to_sym - to coerce the value of location to a symbol you can use to access from the object
  puts location_descriptions[location.to_sym] if location != previous_location
  previous_location = location
  input = gets.chomp.downcase if location != "outside"
  if input == "quit"
    puts "Bye!"
    # break
    exit
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
    when "look"
      puts "You see three doors: one each to the north, east, and west."
    end
  when "study"
    case input
    when "south"
      location = "hall"
    when "look"
      puts "You see a safe. You see a desk."
    when "look at desk"
      puts "You see a piece of paper that reads, The combination is #{safe_combination}."
    when "enter combination #{safe_combination}"
      if safe == "full"
        safe = "empty"
        inventory.push("diamonds")
        puts "You see some diamonds in the safe, pick them up and make your escape."
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
        puts '"That\'s a relief" the man sighs. "You should look at the desk in the study to the east before you leave."'
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