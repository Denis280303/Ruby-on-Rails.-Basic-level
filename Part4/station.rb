class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  #Приймаємо потяг
  def set_train(train)
    @trains.push(train) unless trains.include?(train)
  end

  #Показуємо всі потяги
  def list_all_trains
    puts "Потяги на станції: #{@trains}"
  end

  #Відправляє потяг з поточної станції
  def send_train(train)
    @trains.delete(train) if trains.include?(train)
    puts "Потяг №#{train.num} відправився зі станції #{name}"
  end

  #Показуємо потяги залежно від типу
  def list_trains_by_type(type)
    puts "Потяги за обраним типом:"
    puts @trains.select { |train| train.type == type}
  end
end