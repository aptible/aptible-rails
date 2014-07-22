require 'aptible/auth'
require 'aptible/api'

module Aptible
  module Rails
    module Controller
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :current_organization, :user_url,
                      :organization_url, :criterion_by_handle
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
        session[:organization_url] ||= Aptible::Auth::Organization.all(
          token: session_token
        ).first.href
        url = [session[:organization_url], token: service_token]
        @current_organization ||= Aptible::Auth::Organization.find_by_url(*url)
      rescue
        nil
      end

      def current_user_url
        token_subject || session_subject
      end

      # before_action :authenticate_user
      def authenticate_user
        redirect_to Aptible::Rails.configuration.login_url unless current_user
      end

      # before_action :ensure_service_token
      def ensure_service_token
        redirect_to aptible_login_url unless service_token
      end

      # before_action :ensure_auth_key
      def ensure_auth_key
        return if Fridge.configuration.public_key
        Fridge.configure do |config|
          config.public_key = Aptible::Auth.public_key unless ::Rails.env.test?
        end
      end

      def service_token
        return unless session_token && session_token.session
        return @service_token if @service_token

        @service_token = cached_service_token(session_token)
        if Fridge::AccessToken.new(@service_token).valid?
          @service_token
        else
          @service_token = cached_service_token(session_token,
                                                force: true) || session_token
        end
      end

      def cached_service_token(session_token, options = {})
        fail 'Token must be a service token' unless session_token.session
        cache_key = "service_token:#{session_token.session}"
        ::Rails.cache.fetch(cache_key, options) do
          swap_session_token(session_token)
        end
      end

      # rubocop:disable MethodLength
      def swap_session_token(session_token)
        Aptible::Auth::Token.create(
          client_id: Aptible::Rails.configuration.client_id,
          client_secret: Aptible::Rails.configuration.client_secret,
          subject: session_token.serialize
        ).access_token
      rescue OAuth2::Error => e
        if e.code == 'unauthorized'
          nil
        else
          raise 'Could not swap session token, check Client#privileged?'
        end
      end
      # rubocop:enable MethodLength

      def organization_url(id)
        "#{dashboard_url}/organizations/#{id}"
      end

      def user_url(id = current_user.id)
        "#{dashboard_url}/users/#{id}"
      end

      def criterion_by_handle(handle)
        Aptible::Gridiron::Criterion.where(
          handle: handle.to_s,
          token: service_token,
          organization: current_organization
        ).first
      end
    end
  end
end
