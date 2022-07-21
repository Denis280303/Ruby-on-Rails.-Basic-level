#Класс Station (Станция):
#Имеет название, которое указывается при ее создании
class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  #Приймаємо потяг
  def set_train(train)
    @trains << train unless trains.include?(train)
  end

  #Показуємо всі потяги
  def list_all_trains
    @trains
  end

  #Відправляє потяг з поточної станції
  def send_train(train)
    @trains.delete(train) if trains.include?(train)
  end

  #Показуємо потяги залежно від типу
  def list_trains_by_type(type)
    @trains.select { │train│ train.type == type}
  end
end


#Класс Route (Маршрут):
#Имеет начальную и конечную станцию, а также список промежуточных станций. 
#Начальная и конечная станции указываютсся при создании маршрута, 
#а промежуточные могут добавляться между ними.
#Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
  end

  #Додаємо проміжну станцію
  def add_another_station(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  #Видалити проміжну станцію
  def del_another_station(station)
    @stations.delete(station) unless (@stations.first || @stations.last) != station
  end

  #Список всіх станцій
  def list_stations
    @stations.each { |item| puts item.name}
  end
end


#Класс Train (Поезд):
#Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество 
#вагонов, эти данные указываются при создании экземпляра класса
#Может показывать текущую скорость
#Может показывать количество вагонов
#Показывать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  attr_reader :num, :type, :currently_speed, :wags, :current_station
  def initialize(num, type, wags)
    @num = num
    @type = type
    @wags = wags
    @currently_speed = 0
  end

  #Набираємо швидкість
  def accelerate(value)
    @currently_speed += value
  end

  #Поточна швидкість
  def currently_speed
    puts @currently_speed
  end

  #Гальмуємо
  def decelerate(value)
    @currently_speed == 0 ? @currently_speed = 0 : @currently_speed -= value
  end

  #Метод для причеплення вагону
  def attach_wagon
    @wags += 1 if @currently_speed == 0
  end

  #Метод для відчеплення вагону
  def detach_wagon
    @wags -= 1 if @currently_speed == 0
  end

  #Кількість вагонів
  def count_wagons
    puts @wags
  end

  #Может принимать маршрут следования (объект класса Route)
  def get_route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.set_train(self)
    @current_st_index = 0
  end

  #Рух вперед
  def move_forwards
    return unless @route && next_station
    current_station.delete(self)
    @current_st_index += 1
    @current_station.set_train(self)
  end

  #Рух назад
  def move_backwards
    return unless @route && previous_station
    current_station.delete(self)
    @current_st_index -= 1
    @current_station.set_train(self)
  end

  #Попередня зупинка
  def previous_station
    return unless @route
    puts @route.stations[@current_st_index - 1]
  end

  #Поточна станція
  def current_station
    return unless @route
    @route.route[@current_st_index]
  end

  #Наступна зупинка
  def next_station
    return unless @route
    puts @route.stations[@current_st_index + 1]
  end
end

vinnytsia_station = Station.new("Vinnytsia")
khmelytskiy_station = Station.new("Khmelnytskiy")
kozyatun_station = Station.new("Kozyatun")
shepetivka_station = Station.new("Shepetivka")
route = Route.new(vinnytsia_station, khmelytskiy_station)
route.add_another_station(kozyatun_station)
route.add_another_station(shepetivka_station)
route.list_stations
train_293 = Train.new("#293", "пасажирський", 7)
train_293.count_wagons
train_293.move_forwards
train_293.previous_station
train_293.next_station

