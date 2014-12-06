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
        # rubocop:disable MultilineOperationIndentation
        register_url :about_url,
                     aptible_config.marketing_root_url + '/about'
        register_url :apps_url,
                     aptible_config.dashboard_root_url + '/apps'
        register_url :blog_url, 'http://blog.aptible.com'
        register_url :compliance_url, aptible_config.compliance_root_url
        register_url :contact_support_url,
                     aptible_config.marketing_root_url + '/support'
        register_url :contact_url,
                     aptible_config.marketing_root_url + '/contact'
        register_url :dashboard_url, aptible_config.dashboard_root_url
        register_url :dashboard_session_url,
                     aptible_config.dashboard_root_url + '/session'
        register_url :databases_url,
                     aptible_config.dashboard_root_url + '/databases'
        register_url :dashboard_apps_url,
                     aptible_config.dashboard_root_url + '/apps'
        register_url :edit_organization_url,
                     aptible_config.dashboard_root_url + '/organization'
        register_url :edit_user_url,
                     aptible_config.dashboard_root_url + '/settings'
        register_url :incidents_url,
                     aptible_config.compliance_root_url + '/incidents'
        register_url :legal_url, aptible_config.marketing_root_url + '/legal'
        register_url :logout_url, aptible_config.dashboard_root_url + '/logout'
        register_url :marketing_url, aptible_config.marketing_root_url
        register_url :organizations_url,
                     aptible_config.dashboard_root_url + '/organizations'
        register_url :policy_url,
                     aptible_config.compliance_root_url + '/policy'
        register_url :pricing_url,
                     aptible_config.marketing_root_url + '/pricing'
        register_url :responsible_disclosure_url,
                     aptible_config.marketing_root_url +
                     '/legal/responsible_disclosure.html'
        register_url :risk_url, aptible_config.compliance_root_url + '/risk'
        register_url :roles_url, aptible_config.dashboard_root_url + '/roles'
        register_url :security_url,
                     aptible_config.compliance_root_url + '/security'
        register_url :training_url,
                     aptible_config.compliance_root_url + '/training'
        register_url :status_url, 'http://status.aptible.com/'
        register_url :support_url, 'https://support.aptible.com'
        # rubocop:enable MultilineOperationIndentation
      end
    end
  end
end
