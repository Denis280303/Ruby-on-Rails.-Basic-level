require_relative 'company_creater.rb'

class CargoWagon
  include Company
  attr_reader :type
  
  def initialize(total_amount)
    @type = 'cargo'
    @total_amount = total_amount
    @free_amount = total_amount
  end

  def take_amount(num)
    @free_amount -= num if @free_amount - num >= 0
  end

  def print_free_amount
    @free_amount
  end

  def print_left_amount
    @total_amount - @free_amount
  end
end