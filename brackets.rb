def is_open_bracket(b)
  %w|( { [|.include? b
end

def is_closing_bracket(b)
  %w|) } ]|.include? b
end

def get_closing_bracket(b_open)
  case b_open
  when '(' then ')'
  when '{' then '}'
  when '[' then ']'
  else
    raise "Unknown open bracket type '#{b_open}'"
  end
end

def validate(str)
  stack = []
  ok = true

  str.each_char do |b|
    if stack.empty? and !is_open_bracket b
      ok = false
      break
    end

    if !stack.empty?
      bb = stack.last
      if is_open_bracket(bb) and is_closing_bracket(b) and get_closing_bracket(bb) == b
        stack.pop
      elsif is_open_bracket b
        stack.push b
      else
        ok = false
        break
      end
    elsif is_open_bracket b
      stack.push(b)
    end
  end

  ok
end

puts 'Enter string to validate:'
puts "#{validate(gets.chomp) ? 'Ok' : 'Bad'}"