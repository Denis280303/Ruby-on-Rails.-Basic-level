=begin
Заполнить массив числами фибоначи до 100
=end

arr = [0,1]

num = 2
while num <100
	puts num
	arr << num
	num = (arr[-1]) + (arr[-2])
end