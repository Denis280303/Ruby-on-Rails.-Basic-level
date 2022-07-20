#Класс Station (Станция):
#Имеет название, которое указывается при ее создании
#Может принимать поезда (по одному за раз)
class Station
  attr_reader :name, :trains
  def initialize(name)
    @name = name
    @trains = []
  end

  #Может показывать список всех поездов на станции, находящиеся в текущий момент
  def exist(train)
    @trains << train unless trains.include?(train)
  end

  #Может отправлять поезда (по одному за раз, при этом, поезд 
  #удаляется из списка поездов, находящихся на станции).
  def away(train)
    @trains.delete(train) if trains.include?(train)
  end

  #Может показывать список поездов на станции по типу: кол-во грузовых, пассажирских
  def show_type(train)
    @trains.select { │train│ train.type == type}
  end
end


#Класс Route (Маршрут):
#Имеет начальную и конечную станцию, а также список промежуточных станций. 
#Начальная и конечная станции указываютсся при создании маршрута, 
#а промежуточные могут добавляться между ними.
#Может выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :way
  def initialize(start, finish)
    @way = [start, finish]
  end

  #Может добавлять промежуточную станцию в список
  def add(station)
    @way.insert(-2, station) unless @way.include?(station)
  end

  #Может удалять промежуточную станцию из списка
  def del(station)
    @way.delete(station) if @way.include?(station)
  end
end


#Класс Train (Поезд):
#Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество 
#вагонов, эти данные указываются при создании экземпляра класса
#Может показывать текущую скорость
#Может показывать количество вагонов
#Показывать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  attr_reader :currently_speed, :wags, :curr_st
  def initialize(num, type, wags)
    @num = num
    @type = type
    @wags = wags
    @currently_speed = 0
  end

  #Может набирать скорость (вказуємо на скільки збільшити швидкість)
  def speed_up(speed)
    @currently_speed += speed
  end

  #Может тормозить (сбрасывать скорость до нуля)
  def speed_down(speed)
    @currently_speed == 0 ? @currently_speed = 0 : @currently_speed -= speed
  end

  #Может прицеплять/отцеплять вагоны (по одному вагону за операцию, 
  #метод просто увеличивает или уменьшает количество вагонов).
  #користувач вказує "+" для додавання вагону і "-" для віднімання.
  #Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def wags_change(char)
    if char == "+" && @currently_speed == 0
      @wags += 1
    end
    if char == "-" && @currently_speed == 0
      @wags -= 1
    end
  end

  #Может принимать маршрут следования (объект класса Route)
  def trip(route)
    @route = route
    @curr_st = @route.way.first
    @curr_st.exist(self)
  end

  #Может перемещаться между станциями, указанными в маршруте.
  def move
    return unless @curr_st
    curr_st_index = @route.way.find_index(@curr_st)
    return unless curr_st_index + 1 < @route.way.count
    @curr_st.delete(self)
    curr_st_index = @route.way[curr_st_index + 1]
    @last_st = @route.way[curr_st_index - 1]
    @next_st = @route.way[curr_st_index + 1]
    @curr_st.exist(self)
  end

  #Попередня зупинка
  def last
    @last_st
  end

  #Наступна зупинка
  def next
    @next_st
  end
end

start_st = Station.new("Vinnytsia")
finish_st = Station.new("Khmelnytskiy")
aditional_st1 = Station.new("Kozyatun")
aditional_st2 = Station.new("Shepetivka")
trip = Route.new(start_st, finish_st)
trip.add(aditional_st1)
trip.add(aditional_st1)
trip.way
my_train = Train.new("#293", "пасажирський", 7)
my_train.move
last_st = my_train.last
next_st = my_train.next

