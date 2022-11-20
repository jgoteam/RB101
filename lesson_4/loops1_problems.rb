=begin

### Runaway Loop ###

Code:

  loop do
    puts 'Just keep printing...'
  end

Mission:

  Modify so it stops after its first iteration

My solution:

  loop do
    break puts 'Just keep printing...'
  end

  OR

  loop do
    puts 'Just keep printing...'
    break
  end

Given: The latter

### Loopception ###

Code:

    loop do
      puts 'This is the outer loop.'

      loop do
        puts 'This is the inner loop.'
      end
    end

    puts 'This is outside all loops.'

Mission:

Make each loop stop after 1 iteration of each.

My solution:

    loop do
      puts 'This is the outer loop.'

      loop do
        puts 'This is the inner loop.'
        break
      end
      break
    end

    puts 'This is outside all loops.'

### Control the Loop ###

Code:

    iterations = 1

    loop do
      puts "Number of iterations = #{iterations}"
      break
    end

Mission: Modify so the loop breaks after iterating 5 times.

My solution:

    iterations = 1

    loop do
      puts "Number of iterations = #{iterations}"
      iterations += 1
      break if iterations == 6
    end

Bonus Mission: Modify if the break statement moved up one line, before iterations is incremented.

My bonus solution:

    iterations = 1

    loop do
      puts "Number of iterations = #{iterations}"
      break if iterations == 5
      iterations += 1
    end

### Loop on Command ###

Code:

    loop do
      puts 'Should I stop looping?'
      answer = gets.chomp
    end

Mission: Modify so the loop stops when the user inputs yes

My solution:

    loop do
      puts 'Should I stop looping?'
      answer = gets.chomp
      break if answer == 'yes'
    end

### Say Hello ###

Code:

    say_hello = true

    while say_hello
      puts 'Hello!'
      say_hello = false
    end

Mission: Modify so 'Hello!' is printed 5 times

My solution:

    say_hello = true
    counter = 0

    while say_hello
      puts 'Hello!'
      counter += 1
      say_hello = false if counter > 4
    end

### Print While

Mission: print 5 numbers between 0 to 99, inclusive, using a while loop

My solution:

    numbers = []

    while numbers.size < 5
      numbers.push(rand(99))
    end

    numbers.each { |x| puts x }

Given solution:

    numbers = []

    while numbers.size < 5
      numbers << rand(100)
    end

    puts numbers

Note:

rand(max) will generate a random number from greater than or equal to 0 and less than max, NOT less than or equal to max.

### Count Up ###

Code:

    count = 10

    until count == 0
      puts count
      count -= 1
    end

Mission: Modify so that instead of counting down from 10 to 1, it counts up from 1 to 10.

My solution:

    count = 10

    until count == 0
      puts 11-count
      count -= 1
    end

### Print Until ###

Mission: use an until loop to print each number in the array below

numbers = [7, 9, 13, 25, 18]

My solution:

    numbers = [7, 9, 13, 25, 18]
    count = 0

    until count == numbers.size
      puts numbers[count]
      count += 1
    end



### That's Odd ###

Code:
    for i in 1..100
      puts i
    end

Mission: Modify so that the code only outputs i if it's odd.

My solution:

  for i in 1..100
    puts i if i.odd?
  end


### Greet your Friends ###

Code:

    friends = ['Sarah', 'John', 'Hannah', 'Dave']

Mission:

  Modify the above to get this output:

    Hello, Sarah!
    Hello, John!
    Hello, Hannah!
    Hello, Dave!

My solution:

  friends = ['Sarah', 'John', 'Hannah', 'Dave']

  for name in friends
    puts "Hello, #{name}!"
  end

  Note: it is standard in for loops to write 'for friend in friends' instead of as written.

=end
