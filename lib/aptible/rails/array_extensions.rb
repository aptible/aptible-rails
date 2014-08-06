module Aptible
  module Rails
    module ArrayExtensions
      def decorate(options = {})
        map do |object|
          object.decorate(options)
        end
      end
    end
  end
end
