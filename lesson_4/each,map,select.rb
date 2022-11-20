=begin
def a_method
  [1, 2, 3].each do |num|
    puts num * 2
  end

  puts 'hi'
end

p a_method

#path of self when a_method is called:
    # self has the value [1, 2, 3]
    # each is called on self, and returns the original collection. Self remains at [1,2,3]
    # -side effect of printing num * 2 for each element of the array [1, 2, 3]
    # puts sets self to value 'nil'
    # -side effect of printing 'hi'
=end

=begin
On the select method, it returns: a new collection that matches the selection critera - ie those that return a truthy value in the block.
  - the return value of the block is the return value of the last expression in the block

The map method is similar to the select method, the block evaluating each iteration of the collection, also returning the return value of
the last expression in the block.
  - The main difference is that the map method performs transformation instead of selection


