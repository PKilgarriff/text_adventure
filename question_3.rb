# Write an adventure game that the player plays from the command line
# by typing in the commands `north` and `south`.  The game should have
# this behaviour:
# * Two rooms: a passage and a cave.
#   * Passage commands
#     * `north`: `puts`es `You are in a scary cave.`
#   * Cave commands
#     * `south`: `puts`es `You are in a scary passage.`
#     * `north`: `puts`es 'You walk into sunlight.` and the program
#                stops executing.
# * The player starts in the passage.
# * When the player starts the game, the game shouldn't `puts` a room
#   description until the player moves between rooms.
# * If the player enters a command that is incorrect for the
#   situation, nothing happens and nothing is `puts`ed.
#
# * Note: To stop the program when the user wins, don't use `exit` to
#   quit the program because this will break the automated tests.  To
#   exit a while loop early, use the `break` keyword.
#
# * Note: When you run the automated tests, the tests will simulate
#   the user input.  You shouldn't need to enter any input manually.
#   If the tests hang when you run them, it probably means your code
#   doesn't work correctly, yet.
# 
# * Note: To pass the tests, you'll need to `puts` exactly what's
#   expected. Watch out for stray punctuation, capital letters, etc.

# While in the Passage
# `north`: puts "You are in a scary cave."
# While in the Cave
# `south`: puts "You are in a scary passage."
# `north`: puts "You walk into sunlight."

# Passage is furthest south
# Cave is north of passage
  # Cave has a southern door back to the passage
  # Cave has a northern door out to sunlight

location = "passage"

while location != "outside"
  input = gets.chomp.downcase
  next if !(input == "north" || input == "south")

  if location == "passage"
    if input == "north"
      puts "You are in a scary cave."
      location = "cave"
    end
  elsif location == "cave"
    if input == "north"
      puts "You walk into sunlight."
      location = "outside"
    elsif input == "south"
      puts "You are in a scary passage."
      location = "passage"
    end
  end
end