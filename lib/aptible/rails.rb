require 'aptible/rails/version'

require 'gem_config'

module Aptible
  module Rails
    include GemConfig::Base

    default_dashboard_root_url = ENV['APTIBLE_DASHBOARD_ROOT_URL'] ||
                                 'https://dashboard.aptible.com'
    default_marketing_root_url = ENV['APTIBLE_MARKETING_ROOT_URL'] ||
                                 'https://www.aptible.com'
    default_policy_root_url = ENV['APTIBLE_POLICY_ROOT_URL'] ||
                              'https://policy.aptible.com'
    default_risk_root_url = ENV['APTIBLE_RISK_ROOT_URL'] ||
                            'https://risk.aptible.com'

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
      has :marketing_root_url, classes: [String],
                               default: default_marketing_root_url
      has :policy_root_url, classes: [String],
                            default: default_policy_root_url
      has :risk_root_url, classes: [String],
                          default: default_risk_root_url
    end
  end
end

require 'aptible/rails/railtie' if defined?(::Rails)
