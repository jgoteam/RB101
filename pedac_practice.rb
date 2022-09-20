multiples_only = []
factors = []

puts 'Input the target number:'
target = gets.chomp.to_i
natural_num = (1...target).to_a

until factors.size == 2

  if factors.empty?
    puts 'Input (up to) 2 factors. Add your own? (Y/N)'
    puts "(Input 'N' to use the defaults of 3 and 5.)"
  else
    puts 'Add a second factor? (Y/N)'
  end

  input = gets.chomp

  if input.upcase == 'Y' || input.upcase == 'YES'
    puts 'What factor?'
    factor = gets.chomp
    if factor.to_i.to_s == factor.strip
      factors.push(factor.to_i)
    else
      puts "That's not a valid input. Try again."
      redo
    end
  elsif input.upcase == 'N' || input.upcase == 'NO'
    factors = [3, 5] if factors.empty?
    break
  else
    puts "That's not a valid input. Try again."
  end

end

natural_num.each do |x|
  factors.each do |f|
    multiples_only.push(x) if (x % f).zero? && (multiples_only.include?(x) == false)
  end
end

puts 'This code calculates the sum of natural numbers up until a selected target number'
puts 'that are all multiples of one or more of the selected factors.'
puts "Target number: #{target}"
puts "Selected factors: #{factors}"
puts "Sum: #{multiples_only.sum}"
