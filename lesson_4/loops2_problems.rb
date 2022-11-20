#Even or Odd?
=begin
My solution:
    count = 1

    loop do
      puts "#{count} is #{count.even? ? "even!" : "odd!"}"
      count += 1
      break if count > 5
    end

# Catch the Number
=begin
Mission: Modify the code below so that the loop stops if number is equal to or between 0 and 10.

    loop do
      number = rand(100)
      puts number
    end

My solution:

    loop do
      number = rand(100)
      puts number
      break if number >= 0 && number <= 10
    end

# Conditional Loop

process_the_loop = [true, false].sample

if process_the_loop == true
  loop do
    break puts "The loop was processed"
  end
else
  puts "The loop wasn't processed!"
end



# Get the Sum

Mission: Modify the code so "That's correct" is printed and the loop stops when the user inputs 4.  Print "Wrong Answer. Try again!" if the user's answer doesn't equal 4.

loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
  if answer == 4
    puts "That's correct!"
    break
  else
    puts "Wrong answer. Try again!"
  end
end

# Insert Numbers

Mission: Modify the code so that user input gets added to the array, until it contains 5 numbers.

My solution:
    numbers = []

    loop do
      puts 'Enter any number:'
      input = gets.chomp
      if input.to_s.to_i == input.to_i
        numbers << input
      else
        puts "That's not a number. Please try again."
      end
      break if numbers.size == 5
    end
    puts numbers


# Empty the Array

Mission: With the array below, use loop to remove and print each element from first to last. Stop when the array is empty.

My solution (first to last)

  names = ['Sally', 'Joe', 'Lisa', 'Henry']

  loop do
    puts names.shift
    break if names.empty?
  end

  My solution (last to first)

  loop do
    puts names.pop
    break if names.empty?
  end

# Stop Counting

  My solution:

  5.times do |index|
    puts index + 1
    break if index + 1 == 2
  end

  Further exploration:
    5 times, 1 time.



# Only Even

  Mission: Using next, modify the code below so that it only prints positive integers that are even.

    number = 0

    until number == 10
      number += 1
      next if number.odd?
      puts number
    end

    Further exploration: it needs to be placed in the second line, as opposed to the first, because the objective is to print
    out POSITIVE INTEGERS that are also EVEN. Doing that would include 0, which is not positive.

# First to Five

    Mission: Modify the code below so that the loop iterates until either variable equals 5. When it does, break out of the loop and print "5 was reached!"

      number_a = 0
      number_b = 0

      loop do
        number_a += rand(2)
        number_b += rand(2)

        break
      end

    My solution:

      number_a = 0
      number_b = 0

      loop do
        number_a += rand(2)
        number_b += rand(2)
        next unless number_a == 5 || number_b == 5
        puts "5 is reached!"
        break
      end

# Greeting

    My solution:

    def greeting
      puts 'Hello!'
    end

    number_of_greetings = 2

    while number_of_greetings > 0
      greeting
      number_of_greetings -= 1
    end

end

