def is_an_ip_number(i)
  i.to_i >= 0 && i.to_i <= 255
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return word unless is_an_ip_number(word) # modified to see value when 'false'
  end

  word # modified to see value when 'true'
end

word = ""

p dot_separated_ip_address?("255.255.0.0")
p word
p dot_separated_ip_address?("0.255.0.257")
