if ARGV.include? "debug"
  # if 1 === 1
    verbose = true
  else
    verbose = false
  end
  
  p ARGV
  ARGV.clear

  puts "Debugging is ON" if verbose == true
  puts "Debugging is OFF" if verbose == false
  
  input = gets.chomp.downcase
  
  puts input