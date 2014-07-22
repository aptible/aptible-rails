module Aptible
  module Rails
    module DraperExtensions
      def decorate
        klass = self.class.name.split('::').last
        "#{klass}Decorator".constantize.decorate(self)
      end
    end
  end
end
