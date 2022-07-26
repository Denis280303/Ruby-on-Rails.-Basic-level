require_relative 'company_creater.rb'

class CargoWagon
  include Company
  
  def initialize
    @type = 'cargo'
  end
end