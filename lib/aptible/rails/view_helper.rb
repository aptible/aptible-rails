module Aptible
  module Rails
    module ViewHelpers
      def unix_to_formatted_date(unix_timestamp, format = '%m/%d/%Y')
        Time.at(unix_timestamp).to_datetime.strftime(format)
      end

      def gravatar_url(email, size = 80)
        digest = Digest::MD5.hexdigest(email.downcase)
        "https://secure.gravatar.com/avatar/#{digest}?s=#{size}"
      end

      def auth_url(path = '/')
        URI.join Aptible::Auth.configuration.root_url, path
      end

      def controller?(*controller)
        controller.include?(params[:controller])
      end

      def action?(*action)
        action.include?(params[:action])
      end
    end
  end
end
