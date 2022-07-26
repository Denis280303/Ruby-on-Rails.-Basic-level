class Route
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
    validate!
  end

  def validate!
    raise "Першу станцію не введено!" if first.nil?
    raise "Кінцеву станцію не введено!" if last.nil?
    raise "Недостатньо станцій для побудови маршруту" if @stations.empty?
    true
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