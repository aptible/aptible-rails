module Aptible
  module Rails
    class SessionCache < Hash
      attr_accessor :session

      def initialize(options)
        fail 'Invalid session argument' unless options[:session].is_a?(String)
        @session = options[:session]
      end

      def []=(key, value)
        ::Rails.cache.write("#{session}:#{key}", value)
      end

      def [](key)
        ::Rails.cache.read("#{session}:#{key}")
      end
    end
  end
end
