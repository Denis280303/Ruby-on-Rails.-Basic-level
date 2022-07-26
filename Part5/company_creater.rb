module Company
  attr_accessor :name_company

  def set_name_company(name)
  	self.name_company = name
  	puts "Створена компанія: #{self.name_company}"
  end

  def get_name_name_company
    self.name_company
  end

end