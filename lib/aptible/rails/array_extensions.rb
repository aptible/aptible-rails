module Aptible
  module Rails
    module ArrayExtensions
      def decorate
        map(&:decorate)
      end
    end
  end
end
