module Aptible
  module Rails
    module RoutesHelper
      def marketing_url
        'https://www.aptible.com'
      end

      def about_url
        marketing_url + '/about'
      end

      def audits_url
        marketing_url + '/stressfree'
      end

      # Tumblr doesn't support HTTPS w/ our own domain
      def blog_url
        'http://blog.aptible.com'
      end

      def compliance_url
        ENV['APTIBLE_DASHBOARD_ROOT_URL'] + '/compliance'
      end

      def contact_url
        marketing_url + '/contact'
      end

      def dashboard_url
        ENV['APTIBLE_DASHBOARD_ROOT_URL']
      end

      def docs_url
        marketing_url + '/docs'
      end

      def edit_organization_url
        ENV['APTIBLE_DASHBOARD_ROOT_URL'] + '/organization'
      end

      def edit_user_url
        ENV['APTIBLE_DASHBOARD_ROOT_URL'] + '/settings'
      end

      def enterprise_url
        marketing_url + '/enterprise'
      end

      def legal_url
        marketing_url + '/legal'
      end

      def logout_url
        ENV['APTIBLE_DASHBOARD_ROOT_URL'] + '/logout'
      end

      def policy_url
        ENV['APTIBLE_POLICY_ROOT_URL']
      end

      def pricing_url
        marketing_url + '/pricing'
      end

      def privacy_url
        marketing_url + '/privacy'
      end

      def security_url
        marketing_url + '/security'
      end

      # Groove doesn't support HTTPS w/ our own domain
      def support_url
        'http://help.aptible.com'
      end

      # Statuspage.io requires a business-tier plan for SSL
      def status_url
        'http://status.aptible.com/'
      end

      def risk_url
        ENV['APTIBLE_RISK_ROOT_URL']
      end

      def roles_url
        ENV['APTIBLE_DASHBOARD_ROOT_URL'] + '/roles'
      end

      def terms_url
        marketing_url + '/terms'
      end

      def training_url
        marketing_url + '/training'
      end
    end
  end
end
