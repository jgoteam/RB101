#For this practice problem, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:
=begin
The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock! used r align method


greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings


limit = 15

def fib(limit, first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(15, 0, 1)
puts "result is #{result}"
=end

def color_valid(color)
  color == "blue" || color == "green" ? true : false
end