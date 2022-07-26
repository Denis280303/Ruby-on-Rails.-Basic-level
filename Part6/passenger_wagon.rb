require_relative 'company_creater.rb'

class PassengerWagon
  include Company
  
  def initialize
    @type = 'passenger'
  end
end