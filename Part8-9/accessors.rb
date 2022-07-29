module Accessors
  def self.included(receiver)
    receiver.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        name_method = "@#{method}"
        history_method = "@#{method}_history"
        define_method(method) { instance_variable_get(name_method) }
        define_method("#{method}_history") { instance_variable_get(history_method) }

        define_method("#{method}=") do |value|
          if instance_variable_get(history_method).nil?
            instance_variable_set(history_method, [instance_variable_get(name_method)])
          else
            instance_variable_get(history_method) << instance_variable_get(name_method)
          end
          instance_variable_set(name_method, value)
        end
      end
    end
  end

  def strong_attr_acessor(name, type)
    name = "@#{name}"
    define_method(name) { instance_variable_get(name) }
    define_method("@#{name}=") do |value|
      if value.is_a?(type)
        instance_variable_set(name, value)
      else
        raise TypeError
      end
    end
  end
end
