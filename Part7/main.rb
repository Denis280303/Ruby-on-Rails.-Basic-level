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
      puts "Пасажирський потяг створено!"
  	elsif type == "cargo"
  		train = CargoTrain.new(num)
  		@trains.push(train)
      puts "Вантажний потяг створено!"
    else
      raise "Некоректний тип потяга!"
  	end
  rescue RuntimeError
    puts "Введіть коректний тип потяга!"
    retry
  end

  def add_wagon
  	get_current_train
  	if @current_train.type == "passenger"
      puts "Введіть кількість місць у вагоні:"
      num_seats = gets.chomp.to_i
  	  wagon = PassengerWagon.new(num_seats)
  	  @trains[@train_index].attach_wagon(wagon)
  	end
  	if @current_train.type == "cargo"
      puts "Введіть кількість об'єму у вагоні:"
      num_amount = gets.chomp.to_i
  	  wagon = CargoWagon.new(num_amount)
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
  	puts "Список всіх потягів:"
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
      puts "7 - Вивести список потягів на станції"
      puts "8 - Вивести список вагонів у потяга"
      puts "9 - Зайняти місце у вагоні"
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
        when 7
          print_list_trains_on_station
        when 8
          print_list_wags_on_train
        when 9
          set_amount_or_seats_in_wag
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
  	puts "Введіть назву станції:"
  	name = gets.chomp
  	@current_station = @stations.find { |t| t.name == name}
  	@station_index = @stations.find_index(@current_station)
  end

  #Потяги на станції
  def print_list_trains_on_station
    get_current_station
    trains = lambda do |train|
      puts "Номер: #{train.num}, тип: #{train.type}, вагонів: #{train.wags.count}"
    end
    @current_station.train_in(trains)
  end

  #Потяги на станції
  def print_list_wags_on_train
    get_current_train
    n = 1
    wags = lambda do |wag|
      if wag.type == "cargo"
        puts "Номер: #{n}, тип: #{wag.type}"
        puts "Вільного об'єму: #{wag.print_free_amount}"
        puts "Зайнято об'єму: #{wag.print_left_amount}"
      else
        puts "Номер: #{n}, тип: #{wag.type}"
        puts "Вільних місць: #{wag.print_free_seats}"
        puts "Зайнято місць: #{wag.print_left_seats}"
      end
      n += 1
    end
    @current_train.wag_in(wags)
  end

  #Метод для зайняття місць або об'єму у вагоні
  def set_amount_or_seats_in_wag
    print_list_wags_on_train
    puts "Вкажіть номер вагону"
    wag_number = gets.chomp.to_i
    current_wagon = @current_train.wags[wag_number-1]
    if current_wagon.type == "cargo"
      puts "Введіть кількість об'єму, який потрібно зайняти"
      num = gets.chomp.to_i
      current_wagon.take_amount(num)
      puts "Вказаний об'єм зайнято!"
    else
      current_wagon.take_seat
      puts "Одне місце зайнято!"
    end
  end
end

choice = Main.new
choice.run