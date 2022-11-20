# ['ant', 'bat', 'caterpillar'].count { |str| str.include?('z') }
# vs.
# ['ant', 'bat', 'caterpillar'].count do |str|
#   str.include?('z')
# end

=begin
{} blocks binds more tightly than do..end blocks ??
=end

#3. The 'reject' method returns a collection of elements that have been evaluated as 'falsy' aka false or nil. NOT truthy!!

=begin

#4

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

Predicted output:

{'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}

#5

hash = { a: 'ant', b: 'bear' }
hash.shift
p hash # {:b => 'bear'}
# we can test by using the p method

#6

['ant', 'bear', 'caterpillar'].pop.size # 10, as it takes the size of the return value of pop, which is the last element of the array.\
# it should be 11, as caterpillar has 11 letters, not 11.

#7

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# Mission:
#   - return value of the block?
#   - reasoning?
#   - return value of any? what is the output?

# The return value of the block would be true. This is the case as each element in the array, starting from index 0, is evaluated. The last two elements
# is not evaluted as ruby already has an element that evalutes as true. Noted the return value of the block is determined by the last statement of the block
# return value is true, with the output of:
# 1


#8
arr = [1, 2, 3, 4, 5]
p arr.take(2)
p arr

# the take method takes one parameter; that argument determines how many elements will be returned, starting from index 0.

#9

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# Noted that map ALWAYS outputs an array, and that for an if statement, if the condition is not evaluated as true, then it returns 'nil'.

#10

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# Predicted output: [1, nil, nil]
=end




