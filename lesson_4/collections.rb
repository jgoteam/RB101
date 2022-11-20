=begin

str[2,3] is syntatic sugar for str.slice(2,3)

str = 'The grass is green'

Mission: reference 'grass' str

My solution:

str.slice(4, 5) OR
str[4,5]

Though strings act like colllections in that you can access individual chars ex. str[0], str[1,2]
these methods will assign a brand new string; its not referenced.

=end

=begin

arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
p arr[2, 3]
p arr[2, 3][0]

My solution:
  ['c', 'd', 'e']
  ['c']

In irb:
  mistake! for p arr[2,3][0], its output is a new string, not a new string as the only element in an array!
  This happens when you pass the method only a single index, otherwise, it would return a new array

=end

=begin
fetch versus straight element reference

  - both methods will try to return the value at the given index.HOWEVER,
    - fetch will throw an "out of index" error or "key error" for hash
    - []= will return the value nil


str = "joe's favorite color is blue"
str[0] = 'J'
str[6] = 'F'
str[15] = 'C'
str[21] = 'I'
str[24] = 'B'

=end

=begin
arr = [1, 2, 3, 4, 5]
arr[0] += 1 # => 2
arr         # => [2, 2, 3, 4, 5]

# Mission: now increase the rest of the elements by 1 as well.

My solution:

  arr.each_with_index { |_, idx| arr[idx] += 1 if idx != 0 }

Given solution: arr[1] += 1, for each element in the array

Noted: The []= method IS destructive!!! Remember this


hsh = { apple: 'Produce', carrot: 'Produce', pear: 'Produce', broccoli: 'Produce' }

hsh[:apple] = 'Fruit'
hsh[:carrot] = 'Vegetable'
hsh[:pear] = 'Fruit'
hsh[:broccoli] = 'Vegetable'

p hsh # => { :apple => "Fruit", :carrot => "Produce", :pear => "Produce", :broccoli => "Produce" }

Hash is similar; instead of the index number, you have the key.

=end





