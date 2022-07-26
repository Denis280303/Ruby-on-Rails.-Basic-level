require_relative 'company_creater.rb'
require_relative 'instance_counter.rb'

class Train
  include Company
  attr_reader :num, :type, :currently_speed, :wags, :current_station

  @@trains_list = {}

  def initialize(num)
    register_instance
    @num = num
    @type = type
    @wags = []
    @currently_speed = 0
    @@trains_list[num] = self
  end

  def self.find(number)
    if @@trains_list[number].nil?
      puts "Об'єкт з даним номером не знайдено!"
    else
      @@trains_list[number]
    end
  end

  #Набираємо швидкість
  def accelerate(value)
    @currently_speed += value
  end

  #Поточна швидкість
  def currently_speed
    puts "Поточна швидкість: #{@currently_speed}"
  end

  #Гальмуємо
  def decelerate(value)
    @currently_speed == 0 ? @currently_speed = 0 : @currently_speed -= value
  end

  #Метод для причеплення вагону
  def attach_wagon(wagon)
    if @currently_speed != 0
      puts "Зупиніть потяг, потім додайте вагони!"
    else 
      @wags.push(wagon)
    end
  end

  #Метод для відчеплення вагону (по логіці він відчеплює завжди з останнього вагону 1 вагон)
  def detach_wagon
    if @currently_speed != 0
      puts "Зупиніть потяг, потім додайте вагони!"
    else 
      @wags.delete_at(-1)
    end
  end

  #Кількість вагонів
  def count_wagons
    puts "Кількість вагонів: #{@wags.count}"
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
    puts "Попередня станція: #{previous_station}"
  end

  #Поточна станція
  def print_current_station
    return unless @route
    @route.route[@current_st_index]
    puts "Поточна станція: #{current_station}"
  end

  #Наступна зупинка
  def print_next_station
    return unless @route
    next_station = @route.stations[@current_st_index + 1]
    puts "Наступна станція: #{next_station}"
  end
end