# player_alive = true
# 
# intro_text = [
#   "You are standing in a room.",
#   "There are three doors, one to the left, one to the right, and one in front of you.",
#   "Choose a door to go through [Type 'Left', 'Right', or 'Forward']"
# ]
# werewolf = "A snarling werewolf pounces as you open the door, ripping you apart with its claws."
# goblin = "A goblin smiles at you as you enter, before drawing a rusty sword and plunging it into your chest."
# death = "Unfortunately you died - better luck next time!"
# safety = [
#   "You close the door behind you as you enter a room that contains no dangers, but does have three more doors.",
#   "Choose a door to go through [Type 'Left', 'Right', or 'Forward']"
# ]
# 
# puts intro_text
# safe_choices = 0
# 
# while player_alive && (safe_choices < 2)
#   user_input = gets.chomp
#   if user_input.downcase == 'left'
#     puts werewolf
#     puts death
#     exit
#   elsif user_input.downcase == 'right'
#     puts goblin
#     puts death
#     exit
#   elsif user_input.downcase == 'forward'
#     puts safety
#     safe_choices += 1
#   else
#     puts "I'm afraid that's not a direction you can go - please choose 'Left', 'Right', or 'Forward'"
#   end
# end
# 
# puts "You made it out of the dungeon! Safe travels on the way to your next adventure."

location_descriptions = {
  'passage': "You are in a scary passage.",
  'cave': "You are in a scary cave.",
  'hall': "You are in a hall with a marble floor.",
  'study': "You are in a warm and cosy study."
}

previous_location = ""
location = "passage"
# 4 digit safe combination generated randomly each run 
safe_combination = rand(1000...10000)

while location != "outside"
  # puts location
  # IMPORTANT to_sym - to coerce the value of location to a symbol you can use to access from the object
  puts location_descriptions[location.to_sym] if location != previous_location
  input = gets.chomp.downcase
  if input == "quit"
    puts "Bye!"
    break
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
    when "look"
      puts "You see a door."
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
      safe = "open"
      puts "You see some diamonds in the safe, pick them up and make your escape"
    end
  end
end