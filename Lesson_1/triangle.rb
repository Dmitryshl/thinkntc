puts "Hello, please enter first side"
first_side = gets.chomp.to_f
puts "Hello, please enter second side"
second_side = gets.chomp.to_f
puts "Hello, please enter third side"
third_side = gets.chomp.to_f
sides = [first_side, second_side, third_side].sort
hypo = sides.pop
a,b = sides
if hypo**2 == a**2 + b**2
  puts "triangle is rectangular"
  end
if a == b || a == hypo || b == hypo
  puts "triangle is isosceles"
end
if a == b && a == hypo && a == hypo
  puts "triangle is equilateral"
end
