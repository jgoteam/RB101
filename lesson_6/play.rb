

def joinor(num_arr, delimiter = ', ', append_last = 'or')
  if num_arr.size == 1 || num_arr.size == 0
    num_arr.join
  elsif num_arr.size == 2
    "#{num_arr[0]} #{append_last} #{num_arr[1]}"
  else
    num_arr.map.with_index { |i, idx| idx != num_arr.size - 1 ? "#{i}#{delimiter}" : "#{append_last} #{i}" }.join
  end
end

p joinor([1])
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
