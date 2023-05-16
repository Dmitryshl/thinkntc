basket = {}

loop do
  puts 'Enter name of goods'
  product = gets.chomp

  break if product == 'stop'

  puts 'Enter price of goods'
  price = gets.chomp.to_f

  puts 'Enter quantity of goods'
  quantity = gets.chomp.to_f

  basket[product] = { price: price, quantity: quantity }
end
total = 0
basket.each do |product, options|
  total_price = options[:price] * options[:quantity]
  puts "#{product}, price:#{options[:price]},quantity:#{options[:quantity]}, total:#{total_price}"
  total += total_price
end
puts "Total: #{total}"