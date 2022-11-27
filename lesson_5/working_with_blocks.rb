=begin
# Example 3

[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# Mission: walk through self going through the above code.

# My solution:

# The method map called on the nested array object [[1,2], [3,4]].
# Each of these two inner two arrays, [1,2] and [3,4] are passed into the block one at a time, assigned the variable arr
# The inner array, the first on being [1,2] has been assigned to the arr.
  # The method first is called on arr, which returns arr[0], which would be the literal integer 1.
  # The method puts is then called on the literal 1, which has a return value of nil, and has the side effect of printing the integer 1 and a newline.
  # The next line then calls the method first on arr again, which still has the value of [1,2], which again returns arr[0], which is still 1.
  # The block returns the value of the last expression, which is arr.first, which has a value of 1.
# This process repeats for the second nested array being passed into the block and assigned to the variable arr.
  # The block returns the value of the last expression, which in this case would have the value of 3.
# The method map returns its own transformed value, which is [1,3]; this is in contrast to the method `each`, which returns itself.

# Expected output:
# 1
# 3
# map should return [1,3]

# Actual output:
# Expected output is correct.

# Notes:


# Example 4

my_arr = [[18, 7], [3, 12]].each do |arr|
arr.each do |num|
  if num > 5
    puts num
  end
end
end

# My solution:

# The variable my_arr will be equal to the value returned by the method call each on the nested array [[18, 7], [3,12]].

# The method each is called on the nested array [[18,7], [3,12]], with each inner array being passed into the block, assigned to the variable arr.
# On the first pass, arr will have the value of [18,7]. The method each will be called on arr, again passes each element into the block,
#   now assigned to the variable num.
# On first past within the each method call, num with a value of 18 will be evaluated through the `if` conditional statement. Since 18 > 5, it will evaluate
#   as true, and the action method call puts will be executed. Since the action within the `if` condition was executed, the if statement will return the code
#   executed which is `puts num`. This has the side effect of printing 18 newline to the screen.
# This process is repeated for the second pass for the second each method call, and two more times for the second pass of the method call on the outer block arr.
#
# Predicted output and return values:
# Output:
#   18
#   7
#   12
#
# my_arr = [[18,7],[3,12]]
# each innner method call of each will return each nested array; ie [18,7] for the first call, and [3,12] for the second call.

# Actual output, return values:

# Notes:


# Example 5

[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# Expected outcome:
# [[2,4],[6,8]]

# Example 6
=end
