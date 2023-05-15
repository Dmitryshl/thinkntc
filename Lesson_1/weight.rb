puts "Hello, please enter your name"
name = gets.chomp
puts " Ok #{name}, now enter your height"
height = gets.chomp.to_f
ideal_weight = (height - 110) * 1.15
if ideal_weight > 0
  puts "#{name}, you ideal weight is #{ideal_weight} "
else
  puts "You weight is optimal"
end