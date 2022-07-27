#Окремий модуль під перевірку валідності номеру потяга, оскільки
#введення номеру потяга зустрічається часто в багатьох класах
module Validation
	
  NUMBER_FORMAT = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i

  def validate!
    raise "Номер потяга не може бути порожнім!" if num.nil?
    raise "Номер потяга не відповідає формату!" if num.to_s !~ NUMBER_FORMAT
    true
  end
end