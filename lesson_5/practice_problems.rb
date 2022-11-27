=begin
# 1

arr = ['10', '11', '9', '7', '8']

# Mission: Order this array by descending numeric value.

# My solution:

p arr.map(&:to_i).sort.reverse

# Given solution:

arr.sort do |a,b|
  b.to_i <=> a.to_i
end

# 2

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

p books.sort_by { |book| book[:published].to_i }

# 3

arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

# My solution:
# arr1[2][1][3]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

# My solution:
# arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]

# My solution:
# p arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

# My solution:
# hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

# My solution:
# p hsh2[:third].keys[0]

# 4
# Mission: for each of these arrays and hashes, change the value of 3 to 4.
arr1 = [1, [2, 3], 4]

arr1[1][1] = 4

arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

arr2[2] = 4

hsh1 = {first: [1, 2, [3]]}

hsh1[:first][2][0] = 4

hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

hsh2[['a']][:a][2] = 4


# 5

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

p munsters.each_with_object([]) { |munsters, arr| name, stats = *munsters; arr.push(stats["age"]) if stats["gender"] == "male" }.sum

# 6

# Mission: print out the name, age, and gender of each family member with the following format: (Name) is a (age)-year-old (male or female).

munsters.each { |name, stats| puts "#{name} is a #{stats["age"]}-year-old #{stats["gender"]}." }

# 7

a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

# Mission: For the above code, predict what the final values of a and b are.

# My solution:

# [2, [5,8]]
# [4, [5,8]]
# [4, [1,8]]

# a = 4; b = [1,8]
# INCORRECT - TO REVIEW
# The key mistake here is that the 4th line is not modifying the object that a is referencing, which is the immutable literal 2. As opposed to
# b, which is an array, is mutable, and since both the variable b and arr[1] point to the same object, the value of both b and arr[1] will change.

# a = 2; b = [3, 8]; arr = [2, [3, 8]]

# 8

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# Mission: write code to output all the vowels in this hash, using the each method.

# My solution:
hsh.values.join.each_char { |letter| puts letter if /[aeiouAEIOU]/.match?(letter) }

# 9

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# Mission: Sort each subarray in descending order, according to the types of the elements, preserving the order of the outer array.

# My solution
    p arr.map { |subarr| subarr.sort.reverse }

# Given solution
    arr.map do |sub_arr|
      sub_arr.sort do |a, b|
        b <=> a
      end
    end

# 10

arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# Mission: Increment each integer by 1, returning a new array with the `map` method, preserving the structure of the original array.

p arr.map do |hash|
  new_hash = {}
  hash.each do |key, value|
    new_hash[key] = value + 1
  end
  new_hash
end

# 11

arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

# Mission: Using the select or reject methods, create a new array with the same structure, but with elements only containing multiples of 3.

# My solution:
# arr.map { |subarr| subarr.select{ |num| num % 3 == 0 } }

#12

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

# Mission: Without using the to_h method, return a new hash, in which the first subarray is the key, and the second subarray is the value.

# My solution
  arr.each_with_object({}) { |subarray, hash| first, second = *subarray; hash[first] = second }

# Given solution
    hsh = {}
    arr.each do |item|
      hsh[item[0]] = item[1]
    end
    hsh

# 13

arr = [[1, 6, 9], [6, 1, 7], [1, 8, 3], [1, 5, 9]]

# Mission: Return a new array containing the same subarrays, sorted by only the odd numbers they contain.

# My solution:
# arr.sort_by { |x| x.select { |num| num.odd? } }

# 14
=end
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# Mission: Write some code to return an arry containing the colors of the fruits and the sizes of the vegetables.
# Sizes should be uppercase. Colors should be capitalized.

p hsh.each_with_object([]) { |element, new_arr| name, attribute = *element; new_arr.push(element[0][:colors]) ; new_arr.push(element[0][:size]) }



