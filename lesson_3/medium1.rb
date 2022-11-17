=begin
QUESTION 1 For this practice problem, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

sample expected output:

The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!



# My solution
10.times { |x| puts "The Flintstones Rock!".rjust(21 + x) }

# Given solution
10.times { |x| puts (" " * x) + "The Flintstones Rock!" }

QUESTION 2

The result of the following statement will be an error:

puts "the value of 40 + 2 is " + (40 + 2)

Why? And what are two ways to fix this?

# My Solution
There will be a type error? Attempting to concantenate two objects with the values of two different data types.

Two ways to fix:
  - Typecast (40 + 2) to the same type (String)

    Possible code:

      puts "the value of 40 + 2 is " + (40 + 2).to_s
      puts "the value of 40 + 2 is " + String(40 + 2)

 # - Use Interpolation instead - embed (40 + 2) into the first string

      puts "the value of 40 + 2 is #{40 + 2}"

QUESTION 3

My solutions:

  def factors2(num)
    num.zero? ? [0] : (1..num).select { |x| (num % x == 0)}
  end

  def factors3(num)
    divisor = num
    factors = []
    while divisor > 0
      factors << num / divisor if num % divisor == 0
      divisor -= 1
    end
    factors
  end

QUESTION 4

She wrote two implementations saying, "Take your pick. Do you like << or + for modifying the buffer?".
Is there a difference between the two, other than what operator she chose to use to concatenate an element to the buffer?

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

Yes. The first mutates the caller, and then returns a reference to the same caller
The second instantiates a new variable, and does not mutate the caller, returning a reference to the same new variable.

QUESTION 5

What's wrong with the code below?

    limit = 15

    def fib(first_num, second_num)
      while first_num + second_num < limit
        sum = first_num + second_num
        first_num = second_num
        second_num = sum
      end
      sum
    end

    result = fib(0, 1)
    puts "result is #{result}"

The method fib cannot access the local variable limit.
To fix this, you can change the local variable limit to a constant one,
or you can add limit as an argument to the mehod.


QUESTION 6

    What's the expected output?

    answer = 42

    def mess_with_it(some_number)
      some_number += 8
    end

    new_answer = mess_with_it(answer)

    p answer - 8

A: 42

the definition is never utilized nor the variable new_answer

QUESTION 7

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

p munsters

# Expected output:
  "Herman" => { "age" => 74, "gender" => "other" },
  "Lily" => { "age" => 72, "gender" => "other" },
  "Grandpa" => { "age" => 444, "gender" => "other" },
  "Eddie" => { "age" => 52, "gender" => "other" },
  "Marilyn" => { "age" => 65, "gender" => "other"}


# Actual output:
  same

Rationale:

  Ruby is pass by reference value!!!


QUESTION 8

A: "paper"

QUESTION 9

A: "no"
=end

