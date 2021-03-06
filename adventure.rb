# The user starts by facing forward. They can move right, left, or forward.
# If they move right, they die (there's a goblin).
# If they move left, they die (there's a werewolf).
# If they move forward, they live.
# They have to do this twice to win.

player_alive = true

intro_text = [
  "You are standing in a room.",
  "There are three doors, one to the left, one to the right, and one in front of you.",
  "Choose a door to go through [Type 'Left', 'Right', or 'Forward']"
]
werewolf = "A snarling werewolf pounces as you open the door, ripping you apart with its claws."
goblin = "A goblin smiles at you as you enter, before drawing a rusty sword and plunging it into your chest."
death = "Unfortunately you died - better luck next time!"
safety = [
  "You close the door behind you as you enter a room that contains no dangers, but does have three more doors.",
  "Choose a door to go through [Type 'Left', 'Right', or 'Forward']"
]

puts intro_text
safe_choices = 0

while player_alive && (safe_choices < 2)
  user_input = gets.chomp
  if user_input.downcase == 'left'
    puts werewolf
    puts death
    exit
  elsif user_input.downcase == 'right'
    puts goblin
    puts death
    exit
  elsif user_input.downcase == 'forward'
    puts safety
    safe_choices += 1
  else
    puts "I'm afraid that's not a direction you can go - please choose 'Left', 'Right', or 'Forward'"
  end
end

puts "You made it out of the dungeon! Safe travels on the way to your next adventure."