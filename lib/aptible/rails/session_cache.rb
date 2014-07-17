module Aptible
  module Rails
    class SessionCache < Hash
      attr_accessor :session

      def initialize(options)
        fail 'Invalid session argument' unless options[:session].is_a?(String)
        @session = options[:session]
      end

      def fetch(key, value, options = {}, &block)
        self[key] || write(key, block.call, options)
      end

      def write(key, value, options = {})
        ::Rails.cache.write(cache_key(key), value, options)
        value
      end

      def delete(key)
        ::Rails.cache.delete(cache_key(key))
      end

      def []=(key, value)
        write(key, value)
      end

      def [](key)
        ::Rails.cache.read(cache_key(key))
      end

      private

      def cache_key(key)
        "#{session}:#{key}"
      end
    end
  end
end
