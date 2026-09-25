# app.rb

loop do
  puts "\n--- Exercise Tracker ---"
  puts '1. Add a Session'
  puts '2. View Sessions'
  puts '3. Exit'
  print 'Choose an option (1-3): '

  choice = gets.chomp

  case choice
  when '1'
    puts "\n> You chose to add a session."
  when '2'
    puts "\n> You chose to view sessions."
  when '3'
    puts "\n> Goodbye!"
    break
  else
    puts "\n> Invalid choice. Please try again."
  end
end
