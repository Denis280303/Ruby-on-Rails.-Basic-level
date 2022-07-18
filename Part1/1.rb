puts "Введіть своє ім'я:"
name = gets.chomp.capitalize!
puts "Введіть свій зріст:"
growth = gets.chomp.to_i
ideal = growth - 110

puts ideal > 0 ? "#{name}, Ваша ідеальна вага: #{ideal}" : "Ваша вага вже оптимальна"
