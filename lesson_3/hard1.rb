# QUESTION 1

=begin
if false
  greeting = "hello world"
end

greeting

What is the expected output of this code?

My solution:
  - it would throw an error of an undefined variable, in this case for the variable greeting

The solution:
  - This is partially correct; noted that if a variable is initiated within a conditional that is never executed, it is set to the value nil.

# QUESTION 2


greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings # => { a: 'hi'}

# What is the expected output of the last line of code?

# My solution:
#   - it would output { a: 'hi' }, which was its original value.

# The solution:
    { a: 'hi there' }

  Rationale:
    1. The variable greeting was initiated with the value of the hash { a : 'hi' }
      2b. greeting also is actually a pointer to the key :a, which is a pointer to its value 'hi'
    2. The variable informal_greeting appears to be set to the value at the key :a of the hash, which would be the string "hi"
      2a. Informal_greeting is actually also a pointer to the key :a, which, again, is itself is a pointer to the value of the string 'hi'
    3. The code / informal_greeting << ' there' / mutates the value that informal_greeting points to from 'hi' to 'hi there',

# QUESTION 3

  The 3 strings outputted by A) and B) would use the initiated values of the variables, one, two, three. The method mess_with_vars(one, two, three) did not change these assignments. Output:
    "one is one"
    "two is two"
    "three is three"
  The 3 strings outputted by C) is different. In this case the method g.sub! mutates the initiated values referenced by one, two, three. Output:
    "one is two"
    "two is three"
    "three is one"

# QUESTION 4

  def dot_separated_ip_address?(input_string)
    dot_separated_words = input_string.split(".")
    return false if input_string.size != 4
    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      return false unless is_an_ip_number?(word)
    end
    return true
  end

  Mission: Fix the above code

  My solution:

  def dot_separated_ip_address?(input_string)
    dot_separated_words = input_string.split(".")
    return false if input_string.size != 4
    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      return false unless is_an_ip_number?(word)
    end
    return true
  end

  Given solution:

  def dot_separated_ip_address?(input_string)
    dot_separated_words = input_string.split(".")
    return false unless dot_separated_words.size == 4

    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      return false unless is_an_ip_number?(word)
    end

    true
  end

  Notes:

  - What is the state of dot_separated words at the end of the method?
    -Hypothesis: if false, it would be the string that returns false, that is not an ip #; noted that the pop method removes elements
                  from the end, not the beginning. (And returns nil if the array is empty.
                 if true, it would return the first element, which is a string, at that is the last value to be evaluated. (The last to satisfy the
                  condition of the while loop.)
    -testing:

          def is_an_ip_number(i)
            i.to_i >= 0 && i.to_i <= 255
          end

          def dot_separated_ip_address?(input_string)
            dot_separated_words = input_string.split(".")
            return false unless dot_separated_words.size == 4

            while dot_separated_words.size > 0 do
              word = dot_separated_words.pop
              return word unless is_an_ip_number(word) # modified to see value when 'false'
            end

            word # modified to see value when 'true'
          end

          word = ""

          p dot_separated_ip_address?("255.255.0.0")
          p word
          p dot_separated_ip_address?("0.255.0.257")

 =end