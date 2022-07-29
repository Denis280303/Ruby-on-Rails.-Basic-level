module InstanceCounter
  attr_reader :instances

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances_count
      @instances ||= 0
      @instances += 1
    end

    def instances
      @instances
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances_count
    end
  end
end
