def arr(n)
  n == 0 || n == nil ? [] : (0..(n - 1)).map(&:digits).flatten!
end

p arr(3)