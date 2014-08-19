require 'garner'

Garner.configure do |config|
  config.expires_in = 10.minutes
  config.global_cache_options = { expires_in: 10.minutes }
  config.binding_key_strategy = Garner::Strategies::Binding::Key::CacheKey
  config.whiny_nils = false
end

module Aptible
  module Resource
    class Base < HyperResource
      include Garner::Cache::Binding

      def cache_key
        "#{self.class.name}##{id}"
      end
    end
  end
end

# Cache key overrides
# REVIEW: Should these be defined in a different way?
module Fridge
  class AccessToken
    include Garner::Cache::Binding

    def cache_key
      id
    end
  end
end
