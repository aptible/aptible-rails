module Aptible
  module Rails
    module DraperExtensions
      def decorate(options = {})
        klass = self.class.name.split('::').last
        "#{klass}Decorator".constantize.decorate(self, options)
      end
    end
  end
end
