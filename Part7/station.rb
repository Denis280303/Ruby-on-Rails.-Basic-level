class Station
  attr_reader :trains, :name

  @@all_stations = []

  #Метод класа, що показує всі станції
  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all_stations.push(name)
  end

  def validate!
    raise "Назва станції має бути більше ніж 3 символи" if name.length < 3
    raise "Назва є обов'язковим полем" if name.nil?
  end

  #Приймаємо потяг
  def set_train(train)
    @trains.push(train) unless trains.include?(train)
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
    @trains.select { |train| train.type == type}
  end

  #Приймаємо блок в метод і передаємо кожен потяг на станції в блок
  def train_in(block)
    @trains.each { |train| block.call(train)}
  end
end