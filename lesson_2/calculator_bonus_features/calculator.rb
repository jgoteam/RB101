require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
# Set LANGUAGE to 'eng' for English or 'es' for Spanish
LANGUAGE = 'eng'

def prompt(message, post="")
  message = MESSAGES[LANGUAGE][message]
  Kernel.puts("=> #{message} #{post}")
end

def valid_number?(number)
  /^[+-]?\d*\.?\d+$/.match(number)
end

prompt('welcome')

name = ''
loop do
  name = Kernel.gets().chomp().strip()

  if name.empty?
    prompt('error_name')
  else
    break
  end
end

prompt('hi', "#{name}!")

# Array for history of all operations
history = []
loop do
  nums = []
  until nums.size == 2
    nums.size == 0 ? prompt('1st_num') : prompt('2nd_num')

    num = Kernel.gets().chomp().strip()

    if valid_number?(num)
      num.include?(".") ? nums.push(num.to_f) : nums.push(num.to_i)
    else
      prompt('error_num')
    end
  end

  prompt('operator_prompt')

  operator = ''
  loop do
    operator = Kernel.gets().chomp().strip()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('error_op')
    end
  end

  result = case operator
           when '1'
             nums[0] + nums[1]
           when '2'
             nums[0] - nums[1]
           when '3'
             nums[0] * nums[1]
           when '4'
             nums[0] / nums[1]
           end

  op_syms = ['+', '-', 'x', '/']
  computed = "=>\t #{nums[0]} #{op_syms[operator.to_i - 1]}" \
  " #{nums[1]} = #{result}"
  puts computed
  history.push(computed)

  prompt('restart')
  answer = Kernel.gets().chomp().strip()
  break unless answer.downcase().start_with?('y')
end

prompt('goodbye')
puts history
