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
    (1..num).select{ |x| (num % x == 0)} if num != 0
end

def factors3(num)
  divisor = num
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor =- 1
  end
end

p factors3(0)
