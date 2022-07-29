class CargoTrain < Train
  def initialize(num)
    super
    @type = 'cargo'
  end
end
