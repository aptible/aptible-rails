module Aptible
  module Rails
    module UrlHelper
      extend ActiveSupport::Concern

      included do
        def self.register_url(name, url)
          define_method(name) { url }
          helper_method name
        end

        def self.aptible_config
          Aptible::Rails.configuration
        end

        register_url :about_url,
                     aptible_config.marketing_root_url + '/about'
        register_url :apps_url,
                     aptible_config.dashboard_root_url + '/apps'
        register_url :audits_url,
                     aptible_config.marketing_root_url + '/stressfree'
        # Tumblr doesn't support HTTPS w/ our own domain
        register_url :blog_url, 'http://blog.aptible.com'
        register_url :compliance_url,
                     aptible_config.dashboard_root_url + '/compliance'
        register_url :contact_support_url,
                     aptible_config.marketing_root_url + '/support'
        register_url :contact_url,
                     aptible_config.marketing_root_url + '/contact'
        register_url :dashboard_url, aptible_config.dashboard_root_url
        register_url :dashboard_session_url,
                     aptible_config.dashboard_root_url + '/session'
        register_url :databases_url,
                     aptible_config.dashboard_root_url + '/databases'
        register_url :docs_url, aptible_config.marketing_root_url + '/docs'
        register_url :edit_organization_url,
                     aptible_config.dashboard_root_url + '/organization'
        register_url :edit_user_url,
                     aptible_config.dashboard_root_url + '/settings'
        register_url :enterprise_url,
                     aptible_config.marketing_root_url + '/enterprise'
        register_url :legal_url, aptible_config.marketing_root_url + '/legal'
        register_url :logout_url, aptible_config.dashboard_root_url + '/logout'
        register_url :marketing_url, aptible_config.marketing_root_url
        register_url :organizations_url,
                     aptible_config.dashboard_root_url + '/organizations'
        register_url :policy_url, aptible_config.policy_root_url
        register_url :pricing_url,
                     aptible_config.marketing_root_url + '/pricing'
        register_url :privacy_url,
                     aptible_config.marketing_root_url + '/privacy'
        register_url :responsible_disclosure_url,
                     aptible_config.marketing_root_url +
                     '/legal/responsible_disclosure.html'
        register_url :risk_url, aptible_config.risk_root_url
        register_url :roles_url, aptible_config.dashboard_root_url + '/roles'
        register_url :security_url, aptible_config.security_root_url
        register_url :security_marketing_url,
                     aptible_config.marketing_root_url + '/security'
        # Statuspage.io requires a business-tier plan for SSL
        register_url :status_url, 'http://status.aptible.com/'
        # Groove doesn't support HTTPS w/ our own domain
        register_url :support_url, 'http://support.aptible.com'
        register_url :terms_url, aptible_config.marketing_root_url + '/terms'
        register_url :training_url,
                     aptible_config.marketing_root_url + '/training'
      end
    end
  end
end
