module Aptible
  module Rails
    class CacheContext
      include Garner::Cache::Binding

      def initialize(organization, session)
        self.current_organization = organization
        self.current_session = session
      end

      def cache_key
        puts current_organization_id
        "#ORG:#{current_organization_id}#SESSION:#{current_session_id}"
      end

      def current_organization=(organization)
        puts "define current org #{organization.id}"
        @current_organization = organization
      end

      def current_organization_id
        @current_organization.id || ''
      end

      def current_session=(session_token)
        puts "define current session #{session_token.id}"
        @current_session = session_token
      end

      def current_session_id
        @current_session.id || ''
      end
    end
  end
end