require 'aptible/rails/version'
require 'aptible/rails/railtie' if defined?(::Rails)

require 'gem_config'

module Aptible
  module Rails
    include GemConfig::Base

    with_configuration do
      # Where users will be redirected on
      has :login_url, classes: [String], default: '/login'

      has :client_id, classes: [String, NilClass],
                      default: ENV['CLIENT_ID']
      has :client_secret, classes: [String, NilClass],
                          default: ENV['CLIENT_SECRET']
    end
  end
end
