=begin
# hash and arrays both include the enumerable module..
  # for arrays, the block uses one parameter, for each element
  # for hashes, the block  uses two parameters, for each key, value pair
    # let's experiment!
    # what if I try to input two parameters for an array, one paramter for an array?
=end

# p [1, 2, 3].any? { |x| x.odd? }

=begin
produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}
produce.any? { |x, y| y == 'Fruit'}

if you put in only one paramter for this method, it will evaluate the value only??
  - ### question ###

  animals = { a:"ant", b:"bear", c:"cat" }

p animals.first(2).to_h
p [[:a, "ant"], [:b, "bear"]].to_h
=end

### the include method ###
# doesnt take a block, but takes one argument
# for hashes, include only evaluates for keys, not values
#    --ruby style prefers the method keys? and it is more clear and explicit
#    --also, ruby style prefers key? over has_key?
# to search for values in a hash, use value? over has_value?
#     -- of note, can use values.include?, though this uses two method calls.

### Enumerable#partition

# the partition method divides a collection into two collections, depending on the block value:
#   -- ie the first collection for those that evaluates as truthy, and the second collection that does not?
# the return value of the partition method is always an array, ie for both an array and a hash
#
