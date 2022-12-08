loop do
  puts "Enter a move (r - rock; p - paper; s - scissors)"
  conditions = {
    "r" => "s",
    "p" => "r",
    "s" => "p"
  }

  user_move = gets.chomp
  computer_move = conditions.keys.sample

  puts "Computer choose #{computer_move}"

  if conditions[user_move] == computer_move
    puts "You won!"
  elsif computer_move == user_move
    puts "Its a draw."
  elsif conditions[computer_move] == user_move
    puts "You lost."
  end
end