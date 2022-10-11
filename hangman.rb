MAX_MISS_COUNT = 7
misses = 0

puts 'Enter word: '
WORD = gets.chomp
remaining = WORD.clone
guessed_letters = Array.new(WORD.length, nil)

loop do
  puts guessed_letters
    .collect { |l| l == nil ? '_' : l }
    .join ' '

  puts 'Try guess a letter:'
  letter = gets.chomp

  indexes = (0 ... WORD.length).find_all { |i| WORD[i, 1] == letter }
  if indexes.length > 0
    remaining.tr! letter, ''
    indexes.each { |i| guessed_letters[i] = letter }

    if remaining.length == 0
      puts 'You win!'
      exit
    end
  else
    misses += 1
    puts "Misses: #{misses} / #{MAX_MISS_COUNT}"

    if misses == MAX_MISS_COUNT
      puts 'Game over'
      exit
    end
  end
end