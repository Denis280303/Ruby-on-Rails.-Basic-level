require_relative 'validation.rb'

class CargoTrain < Train
  include Validation

  def initialize(num)
    super
    validate!
	  @type = 'cargo'
  end
end
