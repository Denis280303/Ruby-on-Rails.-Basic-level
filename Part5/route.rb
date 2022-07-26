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
    puts "Список всіх станцій:"
    @stations.each { |item| puts item.name}
  end
end