require_relative 'company_creater.rb'
require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Train
  include Company
  include InstanceCounter
  include Validation
  attr_reader :num, :type, :wags, :current_station

  @@trains_list = {}
 
  def initialize(num)
    @num = num
    @type = type
    @wags = []
    validate!
    @currently_speed = 0
    @@trains_list[num] = self  
    register_instance
  end

  def self.find(number)
    if @@trains_list[number].nil?
      raise "Об'єкт з даним номером не знайдено!"
    else
      @@trains_list[number]
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  #Набираємо швидкість
  def accelerate(value)
    @currently_speed += value
  end

  #Поточна швидкість
  def currently_speed
    @currently_speed
  end

  #Гальмуємо
  def decelerate(value)
    @currently_speed == 0 ? @currently_speed = 0 : @currently_speed -= value
  end

  #Метод для причеплення вагону
  def attach_wagon(wagon)
    if @currently_speed != 0
      raise "Зупиніть потяг, потім додайте вагони!"
    else 
      @wags.push(wagon)
    end
  end

  #Метод для відчеплення вагону (по логіці він відчеплює завжди з останнього вагону 1 вагон)
  def detach_wagon
    if @currently_speed != 0
      raise "Зупиніть потяг, потім додайте вагони!"
    else 
      @wags.delete_at(-1)
    end
  end

  #Кількість вагонів
  def count_wagons
    @wags.count
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
  def print_previous_station
    return unless @route
    previous_station = @route.stations[@current_st_index - 1]
  end

  #Поточна станція
  def print_current_station
    return unless @route
    @route.route[@current_st_index]
  end

  #Наступна зупинка
  def print_next_station
    return unless @route
    next_station = @route.stations[@current_st_index + 1]
  end

  def wag_in(block)
    @wags.each { |wag| block.call(wag)}
  end
end