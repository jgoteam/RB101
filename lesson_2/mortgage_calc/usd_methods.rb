def usd(num)
  if num.include?('.')
    new_num = sprintf("%.2f", num)
    whole, decimal = new_num.split('.')
    count = 4
    until count > whole.size
      whole = whole.insert(count, ',')
      count += 4
    end
    "$ #{whole}.#{decimal}"
  else
    whole = num
    count = 4
    until count > whole.size
      whole = whole.insert(count, ',')
      count += 4
    end
    "$ #{whole}"
  end
end

number_one = '1231.2'
number_two = '249938630'

#p usd(number_one)
#p usd(number_two)

def usd(num)
  if num.include?('.')
    num_with_d = format("%.2f", num)
    whole, decimal = num_with_d.split('.')
    whole_sliced = whole.chars.reverse.each_slice(3)
    whole_w_commas = whole_sliced.map(&:join).join(",").reverse
    [whole_w_commas, decimal].join(".").insert(0, "$ ")
  else
    num_sliced = num.chars.reverse.each_slice(3)
    num_sliced.map(&:join).join(",").reverse.insert(0, "$ ")
  end
end

p usd2(number_one)
p usd2(number_two)
