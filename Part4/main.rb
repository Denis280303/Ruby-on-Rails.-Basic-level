require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'cargo_train.rb'
require_relative 'route.rb'

class Main
  attr_accessor :stations, :trains
  def initialize
  	@stations = []
  	@trains = []
  	@passenger_trains = []
  	@cargo_trains = []
  end

  def create_station
  	puts "Введіть назву станції"
  	name = gets.chomp
  	station = Station.new(name)
  	@stations.push(station)
  	puts "Станцію створено!"
  end

  def create_train
  	puts "Введіть тип потяга ('passenger' or 'cargo')"
  	type = gets.chomp
  	puts "Введіть номер потяга (номери не повторюються):"
  	num = gets.chomp
  	if type == "passenger"
  		train = PassengerTrain.new(num)
  		@trains.push(train)
  	end
  	if type == "cargo"
  		train = CargoTrain.new(num)
  		@trains.push(train)
  	end
  	puts "Потяг створено!"
  end

  def add_wagon
  	get_current_train
  	if @current_train.type == "passenger"
  	  wagon = PassengerWagon.new()
  	  @trains[@train_index].attach_wagon(wagon)
  	end
  	if @current_train.type == "cargo"
  	  wagon = CargoWagon.new()
  	  @trains[@train_index].attach_wagon(wagon)
  	end
  	puts "Вагон додано!"
  end

  def delete_wagon
  	get_current_train
  	@trains[@train_index].detach_wagon
  	puts "Вагон відчеплено!"
  end

  def set_train_on_station
  	get_current_station
  	get_current_train
  	@stations[@station_index].set_train(@trains[@train_index])
  	puts "Потяг переміщено на станцію #{@stations[@station_index]}"
  end

  def print_all_stations
  	puts "Список всіх станцій:"
  	@stations.each { |item| puts item.name}
  end

  def print_all_trains
  	puts "Список всіх пасажирських потягів:"
  	@trains.each { |item| puts item.num}
  end

  def run
  	loop do
  	  puts "----------------------"
  	  puts "Оберіть:"
  	  puts "1 - Створити станцію"
  	  puts "2 - Створити потяг"
  	  puts "3 - Додати вагон"
  	  puts "4 - Відчепити вагон"
  	  puts "5 - Помістити потяг на станцію"
  	  puts "6 - Показати список всіх потягів і станцій"
  	  answer = gets.chomp.to_i
  	  case answer
  	    when 1
  	  	  create_station
  	    when 2
  	      create_train
  	    when 3
  	  	  add_wagon
  	    when 4
  	  	  delete_wagon
  	    when 5
  	  	  set_train_on_station
  	    when 6
  	  	  print_all_trains
  	  	  print_all_stations
  	  end
  	end
  end

private
#Поставив private, тому що ці методи мають бути сховані від виклику поза класом
#так як методи потрібні тільки для даного класу

  def get_current_train
  	puts "Введіть номер потрібного потяга:"
  	num = gets.chomp
  	@current_train = @trains.find { |t| t.num == num}
  	@train_index = @trains.find_index(@current_train)
  end

  def get_current_station
  	puts "Введіть назву станції, до якої потрібно помістити потяг:"
  	name = gets.chomp
  	@current_station = @stations.find { |t| t.name == name}
  	@station_index = @stations.find_index(@current_station)
  end

end

choice = Main.new
choice.run