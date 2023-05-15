puts "Hello, please enter a"
a = gets.chomp.to_f
puts "Hello, please enter b"
b = gets.chomp.to_f
puts "Hello, please enter с"
c = gets.chomp.to_f
d = b**2 - 4 * a * c
if  d > 0
  d_sqrt = Math.sqrt(d)
  x1 = (- b + d_sqrt) / (2 * a)
  x2 = (- b - d_sqrt) / (2 * a)
  puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
elsif d == 0
  x = -b / (2 * a)
  puts "D = #{d}, x = #{x}"
else d < 0
puts "D = #{d} , no roots"
end