module Aptible
  module Rails
    class CacheContext
      include Garner::Cache::Binding

      def initialize(organization, session)
        self.current_organization = organization
        self.current_session = session
      end

      def cache_key
        "organization=#{current_organization_id}&session=#{current_session_id}"
      end

      def current_organization=(organization)
        @current_organization = organization
      end

      def current_organization_id
        @current_organization.id || ''
      end

      def current_session=(session_token)
        @current_session = session_token
      end

      def current_session_id
        @current_session.id || ''
      end
    end
  end
end