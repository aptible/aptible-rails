module Aptible
  module Rails
    class CacheContext
      include Garner::Cache::Binding

      attr_writer :current_organization, :current_session

      def initialize(organization, session)
        self.current_organization = organization
        self.current_session = session
      end

      def cache_key
        "organization=#{current_organization_id}&session=#{current_session_id}"
      end

      def current_organization_id
        @current_organization.id || ''
      end

      def current_session_id
        @current_session.id || ''
      end
    end
  end
end
