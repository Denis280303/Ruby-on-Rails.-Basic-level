require_relative 'validation_main.rb'
class Station
  # include Accessors
  include Validation

  NAME_STATION = /^[a-zа-я\d]/i.freeze

  attr_reader :trains, :name, :cargo_train, :passenger_train

  @@all_stations = []

  validate :name, :presence
  validate :name, :format, NAME_STATION
  validate :attribute_class, :type, 'Station'

  # Метод класа, що показує всі станції
  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @attribute_class = self.class.to_s
    validate!
    @trains = []
    @@all_stations.push(name)
  end

  # Приймаємо потяг
  def set_train(train)
    @trains.push(train) unless trains.include?(train)
  end

  # Показуємо всі потяги
  def list_all_trains
    @trains
  end

  # Відправляє потяг з поточної станції
  def send_train(train)
    @trains.delete(train) if trains.include?(train)
  end

  # Показуємо потяги залежно від типу
  def list_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  # Приймаємо блок в метод і передаємо кожен потяг на станції в блок
  def train_in(block)
    @trains.each { |train| block.call(train) }
  end
end
