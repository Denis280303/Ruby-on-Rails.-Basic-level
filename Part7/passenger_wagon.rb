require_relative 'company_creater.rb'

class PassengerWagon
  include Company
  attr_reader :type
  
  def initialize(total_seats)
    @type = 'passenger'
    @total_seats = total_seats
    @free_seats = total_seats
  end

  def take_seat
    @free_seats -= 1
  end

  def print_free_seats
    @free_seats
  end

  def print_left_seats
    @total_seats - @free_seats
  end
end