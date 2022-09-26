loop do
  puts "Enter 3 numbers:"
  numbers = []
  3.times do
    numbers.push(gets.to_i)
  end

  puts "Select operation(+;-;*;/):"

  begin
    res = case gets.chomp
          when "+" then numbers.reduce(:+)
          when "-" then numbers.reduce(:-)
          when "*" then numbers.reduce(:*)
          when "/" then numbers.reduce(:/)
          else nil
          end
  rescue ZeroDivisionError
    puts "Cannot divide by 0"
    res = nil
  end

  if res != nil
    puts res
  end
end
