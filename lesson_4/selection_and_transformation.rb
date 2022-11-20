=begin

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def select_fruit(food)
  fruits_only = {}
  food.each { |key, value| fruits_only[key] = value if value == 'Fruit' }
  fruits_only
end

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}



def double_numbers!(num_arr)
  num_arr.each_with_index { |x, idx| num_arr[idx] = x * 2 }
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers # => [2, 8, 6, 14, 4, 12] if mutating



my_numbers = [1, 4, 3, 7, 2, 6]

def double_odd_numbers(num_arr)
  counter = 0
  new_arr = []

  loop do
    break if counter == num_arr.size
    new_arr << num_arr[counter] * 2 if counter.odd?
    new_arr << num_arr[counter] if counter.even?
    counter += 1
  end
  new_arr
end

p double_odd_numbers(my_numbers)  # => [2, 4, 6, 14, 2, 6]

# not mutated
p my_numbers                      # => [1, 4, 3, 7, 2, 6]



my_numbers = [1, 4, 3, 7, 2, 6]

def multiply(num_arr, i)
  counter = 0
  new_arr = []

  loop do
    break if counter == num_arr.size
    new_arr[counter] = num_arr[counter] * i
    counter += 1
  end

  new_arr
end

p multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]
p my_numbers

=end