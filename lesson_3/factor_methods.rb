def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end

def factors2(num)
  num.zero? ? [0] : (1..num).select { |x| (num % x == 0)}
end

def factors3(num)
  divisor = num
  factors = []
  while divisor > 0
    factors << num / divisor if num % divisor == 0
    divisor -= 1
  end
  factors
end

p factors(1)
p factors2(0)
p factors3(0)
