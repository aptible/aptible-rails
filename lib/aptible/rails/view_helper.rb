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

      def controller?(*controller)
        controller.include?(params[:controller])
      end

      def action?(*action)
        action.include?(params[:action])
      end

      def verification_code_reset_url
        callback = "#{dashboard_url}/callback?type=verification_code_reset"
        auth_url(
          '/reset',
          type: 'verification_code',
          redirect_uri: callback
        )
      end

      def return_to_context_url(local_assigns)
        href = if controller?('apps')
                 apps_url
               elsif controller?('databases')
                 databases_url
               elsif local_assigns[:compliance_page]
                 compliance_url
               else
                 dashboard_root_url
               end
        URI href
      end
    end
  end
end
