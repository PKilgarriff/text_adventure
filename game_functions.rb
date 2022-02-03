def cellInteraction
  puts "You see a man shackled to the wall."
  puts 'The man asks you "Is it day or night outside?"'
  response = gets.chomp.downcase
  case response
  when "day"
    puts '"That\'s a relief" the man sighs. "You should look at the desk in the study to the north before you leave."'
  when "night"
    $player_alive, $game_running = false
    puts '"Oh dear, it must be a full moon then." the man grunts. "Such a shame, you seemed nice."'
    puts "You watch in horror as the man's features shift and buckle under his skin."
    puts "You have just enough time to see him sprout hair and double in size, before the werewolf tears you apart..."
  end
end