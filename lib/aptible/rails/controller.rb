require 'aptible/auth'
require 'aptible/api'
require 'aptible/gridiron'

module Aptible
  module Rails
    module Controller
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :current_organization, :user_url,
                      :organization_url, :criterion_by_handle, :auth_url,
                      :risk_criterion, :policy_criterion, :security_criterion,
                      :training_criterion, :url_helpers, :compliance_alerts,
                      :criteria, :organization_users, :production_apps
      end

      def current_user
        return unless current_user_url
        @current_user ||= Aptible::Auth::User.find_by_url(current_user_url,
                                                          token: session_token)
      rescue => e
        clear_session_cookie
        raise e
      end

      def current_organization
        return @current_organization if @current_organization
        url = read_shared_cookie(:organization_url)
        if url
          @current_organization = Aptible::Auth::Organization.find_by_url(
            url, token: session_token
          )
        end
        @current_organization ||= default_organization

      rescue HyperResource::ClientError => e
        raise e unless e.body['code'] == 403
        @current_organization = default_organization
      end

      def organization_users
        @organization_users ||= current_organization.users
      end

      def production_apps
        return @production_apps if @production_apps
        accounts = Aptible::Api::Account.all(token: session_token)
        accounts = accounts.select do |account|
          next unless account.type == 'production'
          next unless account.organization == current_organization
          true
        end
        accounts.map(&:apps).flatten.compact
      end

      def current_organization=(organization)
        write_shared_cookie(:organization_url, organization.href)
      end

      def current_user_url
        token_subject || session_subject
      end

      def default_organization
        return @current_organization if @current_organization
        orgs = Aptible::Auth::Organization.all(token: session_token)
        self.current_organization = orgs.first if orgs.any?
      end

      def clear_current_organization
        delete_shared_cookie(:organization_url)
      end

      # before_action :authenticate_user
      def authenticate_user
        redirect_to Aptible::Rails.configuration.login_url unless current_user
      end

      # before_action :ensure_compliance_plan
      def ensure_compliance_plan
        unless current_organization &&
               current_organization.can_manage_compliance?
          redirect_to compliance_url
        end
      end

      # before_action :ensure_auth_key
      def ensure_auth_key
        return if Fridge.configuration.public_key
        Fridge.configure do |config|
          config.public_key = Aptible::Auth.public_key unless ::Rails.env.test?
        end
      end

      def criteria
        @criteria ||= Aptible::Gridiron::Criterion.where(
          token: session_token,
          organization: current_organization
        )
      end

      def compliance_alerts
        return @compliance_alerts if @compliance_alerts
        @compliance_alerts = ComplianceAlertCollection.new(
          criteria, production_apps, organization_users
        ).all
      end

      def organization_url(id)
        "#{dashboard_url}/organizations/#{id}"
      end

      def user_url(id = current_user.id)
        "#{dashboard_url}/users/#{id}"
      end

      def criterion_by_handle(handle)
        Aptible::Gridiron::Criterion.where(
          handle: handle.to_s,
          token: session_token,
          organization: current_organization
        ).first
      end

      def auth_url(path = '/', params = {})
        uri = URI.join(Aptible::Auth.configuration.root_url, path)
        uri.query = params.to_query if params
        uri.to_s
      end

      def risk_criterion
        @risk_criterion ||=
        criterion_by_handle(:risk_assessment).decorate
      end

      def security_criterion
        @security_criterion ||=
        criterion_by_handle(:app_security_interview).decorate
      end

      def policy_criterion
        @policy_criterion ||= criterion_by_handle(:policy_manual).decorate
      end

      def training_criterion
        @training_criterion ||= criterion_by_handle('training_log').decorate
      end

      def bootstrap_backbone
        return unless current_user

        gon.current_user = current_user.attributes
        gon.security_officer = current_organization.security_officer.attributes
        gon.current_organization = current_organization.attributes
        organization_users = current_organization.users
        gon.current_organization_users = organization_users.map(&:attributes)
      end
    end
  end
end
