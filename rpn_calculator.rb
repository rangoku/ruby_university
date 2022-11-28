class RPN
  PRIORITIES = {
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2,
    '**' => 3
  }

  def initialize
    for m in Math.methods
      PRIORITIES[m.to_s] = 3
    end
  end

  public
  def evaluate(expr)
    values = []
    operands = []
    tokens = expr.to_s.split ' '

    rpn = []

    for token in tokens

      if !(PRIORITIES.keys.include? token) and token != '(' and token != ')'
        values.push(token.to_f)
        next
      end

      if operands.length > 0 and token != '(' and token != ')' and operands.last != '(' and  PRIORITIES.keys.include? token and PRIORITIES[token] <= PRIORITIES[operands.last]
        ops_copy = operands.dup
        while !ops_copy.empty? and ops_copy.last != '(' and PRIORITIES[token] <= PRIORITIES[ops_copy.pop]
          values.push eval_next values, operands.pop
        end

        operands.push token
      elsif token === ')'
        ops_copy = operands.dup
        while !ops_copy.empty? and ops_copy.pop != '('
          values.push eval_next values, operands.pop
        end

        if operands.last == '('
          operands.pop
        end

      else
        operands.push token
      end

    end

    unless operands.empty?
      for op in operands.reverse
        values.push eval_next values, op
      end
    end

    [values, operands, rpn]
  end

  public
  def is_supported_func(token)
    begin
      return Math.method(token).arity == 1
    rescue
      return false
    end
  end

  RPN = ''

  private
  def eval_next(values, op)
    val2 = values.pop

    if is_supported_func op
      return Math.method(op).(val2)
    end

    val1 = values.pop

    if val1 == nil or val2 == nil
      return [val1 == nil ? val2 : val1]
    end

    val1.send op, val2
  end
end

loop do
  rpn = RPN.new
  p rpn.evaluate gets.chomp
end

