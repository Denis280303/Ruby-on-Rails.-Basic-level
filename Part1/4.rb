puts "Введіть a:"
a = gets.chomp.to_i
puts "Введіть b:"
b = gets.chomp.to_i
puts "Введіть c:"
c = gets.chomp.to_i

d = b**2 - 4 * a * c
if d < 0
  puts "Дискримінант = #{d}. Коренів немає!"
elsif d == 0
  puts "Дискримінант =  #{d}. Корінь = #{-b/(a * 2)}!"
else
  puts "Дискримінант =  #{d}. Корінь х1 = #{(-b - Math.sqrt(d))/(a * 2)}, х2 = #{(-b - Math.sqrt(d))/(a * 2)}"
end