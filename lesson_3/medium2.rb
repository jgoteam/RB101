# Question 5
=begin
def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# Mission: set my_string to "pumpkinsrutabaga" AND my_array to ["pumpkins", "rutabaga"] WITHOUT mutating the arguments

# My attempt:

def tricky_method(a_string_param, an_array_param)
  a_string_param = "#{a_string_param}rutabaga"
  an_array_param = an_array_param + ["rutabaga"]
  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"


QUESTION 6

def color_valid(color)
  if color == "blue" || color == "green"
    true
  else
    false
  end
end

# Mission: Simplify without changing its return value

# My solution:

def color_valid(color)
  color == blue || color == green
end

=end