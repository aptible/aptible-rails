require 'aptible/auth'
require 'aptible/api'

module Aptible
  module Rails
    module Controller
      extend ActiveSupport::Concern

      included do
        helper_method :auth, :api, :current_aptible_user,
                      :current_organization
      end

      def auth
        @auth ||= Aptible::Auth::Agent.new(token: service_token).get
      end

      def api
        @api ||= Aptible::Api::Agent.new(token: service_token).get
      end

      def current_aptible_user
        @current_user ||= auth.find_by_url(aptible_subject)
      rescue
        clear_session_cookie
      end

      def current_organization
        session[:organization_url] ||= auth.organizations.first.href
        @current_organization ||= Aptible::Auth::Organization.find_by_url(session[:organization_url],
                                                token: service_token)
      end

      def service_token
        return unless aptible_token && aptible_token.session
        @service_token ||= service_token_for(aptible_token)
      end

      def aptible_login_url
        Aptible::Rails.configuration.login_url
      end

      def aptible_subject
        token_subject || session_subject
      end

      def aptible_token
        current_token || session_token
      end

      # before_action :authenticate_user
      def authenticate_aptible_user
        redirect_to aptible_login_url unless current_aptible_user
      end

      # before_action :ensure_service_token
      def ensure_service_token
        redirect_to aptible_login_url unless service_token
      end

      def service_token_for(token)
        service_token = fetch_service_token(token)
        if Fridge::AccessToken.new(service_token).valid?
          service_token
        else
          fetch_service_token(token, force: true)
        end
      end

      def fetch_service_token(token, options = {})
        fail 'Token must be a service token' unless token.session
        ::Rails.cache.fetch "service_token:#{token.session}", options do
          swap_session_token(token)
        end
      end

      def swap_session_token(token)
        Aptible::Auth::Token.create(
          client_id: Aptible::Rails.configuration.client_id,
          client_secret: Aptible::Rails.configuration.client_secret,
          subject: token.serialize
        ).access_token
      rescue
        token.serialize
      end
    end
  end
end
