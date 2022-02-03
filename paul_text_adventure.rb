require_relative 'locations'

if ARGV.include? "debug"
  debug = true
else
  debug = false
end
ARGV.clear

# Game Variables
### Moved these to locations.rb
# 4 digit safe combination generated randomly each run 
# safe_combination = rand(1000...10000)
# safe = "full"
$game_running = true
first_loop = true

introduction_text = [
  "Welcome to the Text Adventure!",
  "Move around by typing in one of the compass directions and hitting enter.",
  "You can also type 'look' to get more information about your current location.",
  "If you get stuck, type 'help' to read this message again, or 'quit' to exit the game.",
  "----------------"
]

# Locations Hash moved to locations.rb
locations_hash = Locations::LOCATIONS_HASH

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
  when "quit"
    puts "Bye!"
    # break
    exit
  when 'help'
    puts introduction_text[1..4]
  end

  if input == "look"
    puts locations_hash[location.to_sym][:look].()
  end

<<<<<<< HEAD
  # puts input
  if ['north', 'east', 'south', 'west'].any? { |direction| direction == input }
    # puts locations_hash[location.to_sym][:movement][input.to_sym]
    location = locations_hash[location.to_sym][:movement][input.to_sym]
    puts "You remain in the #{location}" if location == previous_location
=======
  if ['north', 'east', 'south', 'west'].any? == input
    location = locations_hash[location.to_sym][:movement][:input.to_sym]
    puts "You remain in the #{location}" if location = previous_location
>>>>>>> parent of 2c536e3 (Pass block to direction check, Fix comaprison (139))
  end

  case location
  when "study"
    puts "Safe combination is #{safe_combination}." if debug
    case input
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