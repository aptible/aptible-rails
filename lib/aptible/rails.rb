require 'aptible/rails/version'

require 'gem_config'

module Aptible
  module Rails
    include GemConfig::Base

    default_dashboard_root_url = ENV['APTIBLE_DASHBOARD_ROOT_URL'] ||
                                 'https://dashboard.aptible.com'
    default_marketing_root_url = ENV['APTIBLE_MARKETING_ROOT_URL'] ||
                                 'https://www.aptible.com'
    default_compliance_root_url = ENV['APTIBLE_COMPLIANCE_ROOT_URL'] ||
                                  'https://compliance.aptible.com'

    with_configuration do
      # Where users will be redirected on
      has :client_id, classes: [String, NilClass],
                      default: ENV['CLIENT_ID']
      has :client_secret, classes: [String, NilClass],
                          default: ENV['CLIENT_SECRET']
      has :dashboard_root_url, classes: [String],
                               default: default_dashboard_root_url
      has :login_url, classes: [String],
                      default: "#{default_dashboard_root_url}/login"
      has :compliance_root_url, classes: [String],
                                default: default_compliance_root_url
      has :marketing_root_url, classes: [String],
                               default: default_marketing_root_url
    end
  end
end

require 'aptible/rails/railtie' if defined?(::Rails)
