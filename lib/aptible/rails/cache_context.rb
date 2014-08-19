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
        "organization=#{@current_organization.id}&
        session=#{@current_session.id}"
      end
    end
  end
end
