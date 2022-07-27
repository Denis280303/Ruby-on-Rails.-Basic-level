require_relative 'validation.rb'

class PassengerTrain < Train
  include Validation

  def initialize(num)
    super
    validate!
	  @type = 'passenger'
  end
end