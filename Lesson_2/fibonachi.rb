fib1 = [0]
fib2 = 1
while fib2 < 100
  fib1 << fib2
  fib2 = fib1.last(2).sum
end
puts fib1