=begin
# 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# Mission: Turn this array into an hash, where the names are the keys, and the position in the array are the values.

# My solution

flintstones = flintstones.map.with_index { |x, idx| [x.intern, idx] }.to_h


#2

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# Mission: Add up all the ages from the Munster family hash.

# My solution:

p ages.values.sum

# Noted that the Enumerable module is included with Array objects

# 3

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# Mission: Remove people with ages 100 and greater

# ages.delete_if { |_, value| value >= 100}
# p ages

#Given solution: ages.keep_if { |_,value| value < 100 }

# NOTE: keep_if method will return the same collection if no changes were made, but select! will return nil if no changes were made.
# test

p ages.keep_if { |_,value| value < 100 }
p ages.select! { |_,value| value < 100 }

#4

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

#Mission: Pick the minimum age from this hash.

# My solution:

p ages.values.min

#5

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Mission: Find the index of the first name that strated with 'Be'

# My solution:
p flintstones.index { |name| name.start_with?("Be") }

# Given solution:
flintstones.index { |name| name[0, 2] == "Be" }

interesting!!

# 6

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Mission: Change the array so that all the names are just the first three characters. Do not make a new array.

# My solution:

flintstones.map! { |name| name[0, 3] }
p flintstones

#7

statement = "The Flintstones Rock"

# My solution:

letter_counts = {}

statement.delete(" ").chars.each { |x| letter_counts.include?(x) ? letter_counts[x.to_sym] += 1 : letter_counts[x.to_sym] = 1}

p letter_counts


# Given solution:

result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

# Iterating through an array of both lowercase and uppercase letters to fill the letter count hash. Nice!

# 8.


numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
p numbers


numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

p numbers
# What happens when we modify an array while we are iterating over it ? What is the output of the above?

# Predicted output for A
# 1
# 2
# 3
# 4
# The value of numbers would be an empty array. numbers = []

# That is incorrect.
# Reading through solution, and tracing self through code:
# --


# 9
# Mission: Create your own titilze method
words = "the flintstones rock"

# Initial solution
def titilze(word)
  copy = word.dup.chomp.chars
  copy[0].upcase!
  copy.each_with_index { |x, idx| copy[idx + 1].upcase! if x == ' ' }.join
end

# Using capitalize method
def titilze_with_capitalize(word)
  word.split.map(&:capitalize).join(" ")
end

p titilze(words)
p titilze_with_capitalize(words)

# 10

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Mission: Modify the munsters hash to that each hash in each key-value pair has an additional key-value pair ("age group": "kid"/"adult"/"senior")

#   Kid ages 0-17, adults ages 18-64, seniors, ages 65+

# Initial solution:

munsters.each do |key, value|
  if (0..17).include?(value["age"])
    value["age_group"] = "kid"
  elsif (18..64).include?(value["age"])
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end

p munsters

# Given solution:

munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end

=end