=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

abetka = "абвгґдеєжзиіїйклмнопрстуфхцчшщьюя"
golos = "аеєиіїоуюя"

result = {}

golos.each_char {|g| result[golos[g]] = abetka.index(golos[g]) + 1 }

print result
