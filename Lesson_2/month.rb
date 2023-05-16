puts "Enter number"
day = gets.chomp.to_i
puts "Enter month"
month = gets.chomp.to_i
puts "Enter year"
year = gets.chomp.to_i

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days[1] += 1 if (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)

day_of_year = day + days.take(month - 1).sum

puts "This #{day_of_year} day of the year"